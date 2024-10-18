{{ config(
    materialized = "incremental",
    unique_key = "customer_id",
    on_schema_change = 'append_new_columns',
    partition_by = {
      "field": "segment_id",
      "data_type": "int64",
      "range": { "start": 0, "end": 100, "interval": 1}},
    cluster_by = 'last_order_date',
    enabled = false
)}}

{% set count_fields = ['order_id', 'shipping_id', 'return_id'] %}
{% set avg_fields = ['fulfillment_days', 'nps_score'] %}
{% set sum_fields = ['gross_revenue', 'tax_amount', 'net_revenue_before_tax', 'net_revenue_after_tax',
                     'cogs', 'returned_cogs', 'refund_amount', 'payment_fee', 'cm'] %}

WITH
  orders AS (
    SELECT *
      FROM {{ ref('fct_orders') }}
      {%- if is_incremental() %}
      WHERE DATE(order_date) >= (SELECT DATE_SUB(MAX(last_order_date), INTERVAL 3 DAY) FROM {{ this }})
      {%- endif %})


  ,customers AS (
    SELECT customer_id
          ,DATE_DIFF(CURRENT_DATE, MAX(order_date), DAY) AS last_order_days
          ,MIN(order_date) AS first_order_date
          ,MAX(order_date) AS last_order_date
          {% for count_field in count_fields -%}
          ,COUNT({{ count_field }}) AS nb_{{ count_field }}
          {% endfor -%}
          {% for avg_field in avg_fields -%}
          ,ROUND(AVG({{ avg_field }}), 2) AS avg_{{ avg_field }}
          {% endfor -%}
          {% for sum_field in sum_fields -%}
          ,ROUND(SUM({{ sum_field }}), 2) AS total_{{ sum_field }}
          {% endfor %}
      FROM orders
      GROUP BY customer_id)


  ,rfm AS (
    SELECT *
          ,CASE 
            WHEN last_order_days <= 90 THEN "<90 days"
            WHEN last_order_days <= 180 AND last_order_days > 90 THEN "180-90 days"
            WHEN last_order_days <= 365 AND last_order_days > 180 THEN "180-365 days"
            ELSE '>365 days'
            END AS recency
          ,CASE 
            WHEN nb_order_id > 2  THEN "3+ orders"
            WHEN nb_order_id = 2  THEN "2 orders"
            WHEN nb_order_id = 1  THEN "1 order"
            END AS frequency
          ,CASE 
            WHEN nb_order_id > 2 AND last_order_days <= 90 THEN "Loyal Leader"
            WHEN nb_order_id = 2 AND last_order_days <= 90 THEN "Growing Patron"
            WHEN nb_order_id = 1 AND last_order_days <= 90 THEN "New Enthusiast"
            WHEN nb_order_id > 2 AND last_order_days <= 180 AND last_order_days > 90 THEN "Casual Shopper"
            WHEN nb_order_id = 2 AND last_order_days <= 180 AND last_order_days > 90 THEN "Waning Loyalty"
            WHEN nb_order_id = 1 AND last_order_days <= 180 AND last_order_days > 90 THEN "Slipping Newcomer"
            WHEN nb_order_id > 2 AND last_order_days <= 365 AND last_order_days > 180 THEN "At-Risk Regular"
            WHEN nb_order_id = 2 AND last_order_days <= 365 AND last_order_days > 180 THEN "Vanished Buyer"
            WHEN nb_order_id = 1 AND last_order_days <= 365 AND last_order_days > 180 THEN "One-Time Buyer"
            ELSE "Dormant Customer" END AS segment
        FROM customers)


  ,final AS (
    SELECT customer_id
          ,first_order_date
          ,last_order_date
          ,last_order_days
          ,recency
          ,nb_order_id
          ,frequency
          ,segment
          ,CASE segment
            WHEN "Loyal Leader" THEN 1
            WHEN "Growing Patron" THEN 2
            WHEN "New Enthusiast" THEN 3
            WHEN "Casual Shopper" THEN 4
            WHEN "Waning Loyalty" THEN 5
            WHEN "Slipping Newcomer" THEN 6
            WHEN "At-Risk Regular" THEN 7
            WHEN "Vanished Buyer" THEN 8
            WHEN "One-Time Buyer" THEN 9
            WHEN "Dormant Customer" THEN 10
            END AS segment_id
          ,nb_shipping_id
          ,nb_return_id
          ,avg_fulfillment_days
          ,avg_nps_score
          ,total_gross_revenue
          ,total_tax_amount
          ,total_net_revenue_before_tax
          ,total_net_revenue_after_tax
          ,total_cogs
          ,total_returned_cogs
          ,total_refund_amount
          ,total_payment_fee
          ,total_cm
      FROM rfm)


  SELECT *
    FROM final