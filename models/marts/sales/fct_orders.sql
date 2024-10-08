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


{% set net_revenue_thresholds = [100, 250, 500] %}

WITH
  int_orders AS (
    SELECT *
      FROM {{ ref('int_orders_joined') }}
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
      FROM {{ ref('int_payments_joined') }}
      GROUP BY order_id)


  ,orders_payments AS (
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
        FROM orders_payments)


    ,customers AS (
      SELECT customer_id
            ,order_id
            ,MIN(DATE(order_date)) OVER (PARTITION BY customer_id) AS first_order_date
            ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_order_nb
        FROM contribution_margin)


    ,cm_customers AS (
      SELECT *
            ,IF(customer_order_nb > 1, 'Returning', 'New') AS customer_type
            ,SUM(net_revenue_after_tax) OVER (PARTITION BY customer_id ORDER BY customer_order_nb ROWS UNBOUNDED PRECEDING) AS customer_cumulative_net_revenue
        FROM contribution_margin
        LEFT JOIN customers USING (customer_id, order_id))


    ,cumulative_revenue AS (
      SELECT *
             {%- for threshold in net_revenue_thresholds %}
             ,MIN(CASE WHEN customer_cumulative_net_revenue >= {{ threshold }} THEN customer_order_nb END) OVER (PARTITION BY customer_id) AS customer_orders_to_{{ threshold }}_net_revenue
             {%- endfor %}
        FROM cm_customers)


    ,final AS (
      SELECT *
        FROM cumulative_revenue)


  SELECT *
    FROM final