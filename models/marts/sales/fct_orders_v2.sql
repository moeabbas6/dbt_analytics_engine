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
  int_orders_payments_joined AS (
    SELECT *
      FROM {{ ref('int_orders_payments_joined') }}
      {%- if is_incremental() %}
      WHERE order_date >= (SELECT DATE_SUB(MAX(order_date), INTERVAL 3 DAY) FROM {{ this }})
      {%- endif -%})


  ,orders_payments AS (
      SELECT country_id
            ,country
            ,order_id
            ,order_status
            ,customer_id
            ,nb_payments
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
            ,product_category
            ,product_name
            ,SAFE_ADD(inbound_shipping_cost, product_cost) AS cogs
            ,return_id
            ,is_returned
            ,return_date
            ,return_reason
            ,IF(is_returned IS TRUE, SAFE_ADD(inbound_shipping_cost, product_cost), 0) AS returned_cogs
            ,IF(is_returned IS TRUE, SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), 0) AS refund_amount
            ,payment_fee
            ,first_order_date
            ,customer_order_nb
            ,IF(customer_order_nb > 1, 'Returning', 'New') AS customer_type
        FROM int_orders_payments_joined)


    ,contribution_margin AS (
      SELECT *
            ,COALESCE(net_revenue_after_tax, 0)
              - COALESCE(cogs, 0)
                - COALESCE(refund_amount, 0)
                  - COALESCE(payment_fee, 0)
                    + COALESCE(returned_cogs, 0) AS cm
        FROM orders_payments)


    ,cumulative_revenue AS (
      SELECT *
            ,SUM(net_revenue_after_tax) OVER (PARTITION BY customer_id ORDER BY customer_order_nb ROWS UNBOUNDED PRECEDING) AS customer_cumulative_net_revenue
        FROM contribution_margin)


    ,customer_orders_to AS (
      SELECT *
             {%- for threshold in net_revenue_thresholds %}
             ,MIN(CASE WHEN customer_cumulative_net_revenue >= {{ threshold }} THEN customer_order_nb END) OVER (PARTITION BY customer_id) AS customer_orders_to_{{ threshold }}_net_revenue
             {%- endfor %}
        FROM cumulative_revenue)


    ,final AS (
      SELECT *
        FROM customer_orders_to)


  SELECT *
    FROM final