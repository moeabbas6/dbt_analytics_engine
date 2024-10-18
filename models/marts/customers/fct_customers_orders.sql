{{ config(
    partition_by = {
      "field": "segment_id",
      "data_type": "int64",
      "range": { "start": 0, "end": 100, "interval": 1}},
    cluster_by = 'last_order_date'
)}}

{% set count_fields = ['order_id', 'shipping_id', 'return_id'] %}
{% set avg_fields = ['fulfillment_days', 'nps_score'] %}
{% set sum_fields = ['gross_revenue', 'net_revenue_after_tax'] %}


WITH
  orders AS (
    SELECT *
      FROM {{ ref('int_orders_payments_joined') }})


  ,customers AS (
    SELECT customer_id
          ,DATE_DIFF(CURRENT_DATE, MAX(order_date), DAY) AS last_order_days
          ,MIN(order_date) AS first_order_date
          ,MAX(order_date) AS last_order_date
          ,DATE_DIFF(MAX(order_date), MIN(order_date), MONTH) + 1 AS customer_lifespan
          {% for count_field in count_fields -%}
          ,COUNT({{ count_field }}) AS nb_{{ count_field }}s
          {% endfor -%}
          {% for avg_field in avg_fields -%}
          ,AVG({{ avg_field }}) AS avg_{{ avg_field }}
          {% endfor -%}
          {% for sum_field in sum_fields -%}
          ,SUM({{ sum_field }}) AS total_{{ sum_field }}
          {% endfor %}
      FROM orders
      GROUP BY customer_id)


  ,customer_lifespan_metric AS (
    SELECT customer_id
          ,AVG(customer_lifespan) AS avg_customer_lifespan
      FROM customers
      GROUP BY customer_id)


  ,customer_monthly_orders AS (
    SELECT customer_id
          ,AVG(orders_per_month) AS avg_orders_per_month
      FROM (SELECT customer_id
                  ,DATE_TRUNC(order_date, MONTH) AS month
                  ,COUNT(order_id) AS orders_per_month
              FROM orders
            GROUP BY customer_id, month)
      GROUP BY customer_id)


  ,customer_metrics AS (
    SELECT *
          ,SAFE_DIVIDE(total_net_revenue_after_tax, nb_order_ids) AS aov
          ,SAFE_DIVIDE(total_net_revenue_after_tax, nb_order_ids)
            * avg_orders_per_month
              * avg_customer_lifespan AS ltv
      FROM customers
      LEFT JOIN customer_lifespan_metric USING (customer_id)
      LEFT JOIN customer_monthly_orders USING (customer_id))


  ,rfm AS (
    SELECT *
          ,CASE 
            WHEN last_order_days <= 90 THEN "<90 days"
            WHEN last_order_days <= 180 AND last_order_days > 90 THEN "180-90 days"
            WHEN last_order_days <= 365 AND last_order_days > 180 THEN "180-365 days"
            ELSE '>365 days'
            END AS recency
          ,CASE 
            WHEN nb_order_ids > 2  THEN "3+ orders"
            WHEN nb_order_ids = 2  THEN "2 orders"
            WHEN nb_order_ids = 1  THEN "1 order"
            END AS frequency
          ,CASE 
            WHEN nb_order_ids > 2 AND last_order_days <= 90 THEN "Loyal Leader"
            WHEN nb_order_ids = 2 AND last_order_days <= 90 THEN "Growing Patron"
            WHEN nb_order_ids = 1 AND last_order_days <= 90 THEN "New Enthusiast"
            WHEN nb_order_ids > 2 AND last_order_days <= 180 AND last_order_days > 90 THEN "Casual Shopper"
            WHEN nb_order_ids = 2 AND last_order_days <= 180 AND last_order_days > 90 THEN "Waning Loyalty"
            WHEN nb_order_ids = 1 AND last_order_days <= 180 AND last_order_days > 90 THEN "Slipping Newcomer"
            WHEN nb_order_ids > 2 AND last_order_days <= 365 AND last_order_days > 180 THEN "At-Risk Regular"
            WHEN nb_order_ids = 2 AND last_order_days <= 365 AND last_order_days > 180 THEN "Vanished Buyer"
            WHEN nb_order_ids = 1 AND last_order_days <= 365 AND last_order_days > 180 THEN "One-Time Buyer"
            ELSE "Dormant" END AS segment
        FROM customer_metrics)


  ,final AS (
    SELECT *
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
            WHEN "Dormant" THEN 10
            END AS segment_id
      FROM rfm)


  SELECT *
    FROM final