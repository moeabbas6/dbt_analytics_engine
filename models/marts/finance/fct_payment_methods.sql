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

{% set payment_methods = ['amazon_pay', 'apple_pay', 'bitcoin', 'stripe'] %}

WITH
  int_payments AS (
    SELECT *
      FROM {{ ref('int_payments_joined') }}
      {%- if is_incremental() %}
      WHERE created_at >= (SELECT DATE_SUB(MAX(order_date), INTERVAL 3 DAY) FROM {{ this }})
      {%- endif -%})


  ,fct_payment_methods AS (
    SELECT country_id
          ,country
          ,order_id
          ,COUNT(order_payment_id) AS nb_payments
          ,IF(COUNT(DISTINCT payment_method) > 1, 'multiple', 'single') AS payment_methods
          ,MAX(created_at) AS order_date
          ,CASE 
           WHEN SUM(IF(payment_status = 'successful', 1, 0)) <> COUNT(order_payment_id) THEN 'failed'
           ELSE 'successful' END AS order_status
          ,SUM(gross_revenue) AS total_gross_revenue
          ,SUM(payment_fee) AS total_payment_fees
          {% for payment_method in payment_methods -%}
          ,SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN payment_fee ELSE 0 END) AS {{ payment_method }}_payment_fees
          {% endfor -%}
          {% for payment_method in payment_methods -%}
          ,SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN gross_revenue ELSE 0 END) AS {{ payment_method }}_amount
          {% endfor -%}
      FROM int_payments
      GROUP BY country_id
              ,country
              ,order_id)


  SELECT *
    FROM fct_payment_methods