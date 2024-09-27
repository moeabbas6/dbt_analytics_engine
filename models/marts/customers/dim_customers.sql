{{ config(
    materialized = "incremental",
    unique_key = "customer_id",
    on_schema_change = 'append_new_columns',
    cluster_by = 'last_order'
)}}

{% set count_fields = ['shipping_id', 'return_id'] %}
{% set avg_fields = ['fulfillment_days', 'nps_score'] %}
{% set sum_fields = ['gross_revenue', 'tax_amount', 'net_revenue_before_tax', 'net_revenue_after_tax',
                     'cogs', 'returned_cogs', 'refund_amount', 'payment_fee', 'cm'] %}

WITH
  orders AS (
    SELECT *
      FROM {{ ref('fct_orders') }}
      {%- if is_incremental() %}
      WHERE DATE(order_date) >= (SELECT DATE_SUB(MAX(last_order), INTERVAL 3 DAY) FROM {{ this }})
      {%- endif %})


  ,customers AS (
    SELECT customer_id
          ,first_name
          ,last_name
          ,COUNT(order_id) AS nb_orders
          ,DATE_DIFF(CURRENT_DATE, MAX(order_date), DAY) AS last_order_days
          ,MIN(order_date) AS first_order
          ,MAX(order_date) AS last_order
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
      GROUP BY customer_id
              ,first_name
              ,last_name)


  ,rfm AS (
    SELECT *
          ,CASE 
            WHEN last_order_days <= 90 THEN "<90 days"
            WHEN last_order_days <= 180 AND last_order_days > 90 THEN "180-90 days"
            WHEN last_order_days <= 365 AND last_order_days > 180 THEN "180-365 days"
            ELSE '>365 days'
            END AS recency
          ,CASE 
            WHEN nb_orders > 2  THEN "3+ orders"
            WHEN nb_orders = 2  THEN "2 orders"
            WHEN nb_orders = 1  THEN "1 order"
            END AS frequency
          ,CASE 
            WHEN nb_orders > 2 AND last_order_days <= 90 THEN "Champion"
            WHEN nb_orders = 2 AND last_order_days <= 90 THEN "Rising Star"
            WHEN nb_orders = 1 AND last_order_days <= 90 THEN "Active Newbie"
            WHEN nb_orders > 2 AND last_order_days <= 180 AND last_order_days > 90 THEN "Occasional"
            WHEN nb_orders = 2 AND last_order_days <= 180 AND last_order_days > 90 THEN "Need Attention"
            WHEN nb_orders = 1 AND last_order_days <= 180 AND last_order_days > 90 THEN "Newbies About to Sleep / Asleep"
            WHEN nb_orders > 2 AND last_order_days <= 365 AND last_order_days > 180 THEN "Cannot / Almost Loose Them"
            WHEN nb_orders = 2 AND last_order_days <= 365 AND last_order_days > 180 THEN "At Risk / Lost 2nd Buyer"
            WHEN nb_orders = 1 AND last_order_days <= 365 AND last_order_days > 180 THEN "Unhappy / Lost 1st Buyer"
            ELSE "Hibernating Customers" END AS segment
        FROM customers)


  SELECT *
    FROM rfm