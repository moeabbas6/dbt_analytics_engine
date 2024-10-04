{{ config(
    materialized = "incremental",
    unique_key = "order_id",
    on_schema_change = 'append_new_columns',
    partition_by = {
      "field": "country_id",
      "data_type": "int64",
      "range": { "start": 0, "end": 100, "interval": 1}},
    cluster_by = 'order_date'
)}}


WITH
  int_orders AS (
    SELECT *
      FROM {{ ref('int_orders') }}
      {%- if is_incremental() %}
      WHERE order_date >= (SELECT DATE_SUB(MAX(order_date), INTERVAL 3 DAY) FROM {{ this }})
      {%- endif -%})


  ,int_payments AS (
    SELECT order_id
          ,COUNT(payment_id) AS nb_payments
          ,MAX(payment_method) AS payment_method
          ,MAX(country_id) AS country_id
          ,MAX(country) AS country
          ,SUM(gross_revenue) AS gross_revenue
          ,MAX(tax_rate) AS tax_rate
          ,SUM(payment_fee) AS payment_fee
      FROM {{ ref('int_payments') }}
      GROUP BY order_id)


  ,joins AS (
      SELECT country_id
            ,country
            ,order_id
            ,order_status
            ,customer_id
            ,nb_payments
            ,first_name
            ,last_name
            ,shipping_id
            ,is_shipped
            ,shipping_amount
            ,payment_method
            ,gross_revenue
            ,tax_rate
            ,SAFE_MULTIPLY(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), SAFE_DIVIDE(tax_rate, 100)) AS tax_amount
            ,SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)) AS net_revenue_before_tax
            ,SAFE_DIVIDE(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), (1 + SAFE_DIVIDE(tax_rate, 100))) AS net_revenue_after_tax
            ,order_date
            ,shipping_date
            ,DATE_DIFF(shipping_date, order_date, DAY) AS fulfillment_days
            ,is_nps
            ,nps_score
            ,nps_date
            ,product_category_id
            ,product_category
            ,product_id
            ,product_name
            ,SAFE_ADD(inbound_shipping_cost, product_cost) AS cogs
            ,return_id
            ,is_returned
            ,return_date
            ,return_reason
            ,IF(is_returned IS TRUE, SAFE_ADD(inbound_shipping_cost, product_cost), 0) AS returned_cogs
            ,IF(is_returned IS TRUE, SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), 0) AS refund_amount
            ,payment_fee
        FROM int_orders
        LEFT JOIN int_payments USING (order_id))


    ,contribution_margin AS (
      SELECT *
            ,COALESCE(net_revenue_after_tax, 0)
              - COALESCE(cogs, 0)
                - COALESCE(refund_amount, 0)
                  - COALESCE(payment_fee, 0)
                    + COALESCE(returned_cogs, 0) AS cm
        FROM joins)


    ,customers AS (
      SELECT customer_id
            ,order_id
            ,order_date AS customer_order_date
            ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_order_nb
        FROM contribution_margin
        GROUP BY ALL)


    ,first_order_customers AS (
      SELECT customer_id
            ,DATE(MIN(customer_order_date)) AS first_order_date
        FROM customers
        GROUP BY customer_id)


    ,final AS (
      SELECT * EXCEPT(customer_order_date)
            ,IF(customer_order_nb > 1, 'Returning', 'New') AS customer_type
        FROM contribution_margin
        LEFT JOIN customers USING (customer_id, order_id)
        LEFT JOIN first_order_customers USING (customer_id))


  SELECT *
    FROM final