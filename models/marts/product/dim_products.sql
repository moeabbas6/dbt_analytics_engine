{{ config(
    materialized = "incremental",
    unique_key = "dim_product_id",
    on_schema_change = 'append_new_columns',
    partition_by = {
      "field": "country_id",
      "data_type": "int64",
      "range": { "start": 0, "end": 100, "interval": 1}},
    cluster_by = 'date'
)}}

{% set count_fields = ['order_id', 'shipping_id', 'return_id'] %}
{% set avg_fields = ['fulfillment_days', 'nps_score'] %}
{% set sum_fields = ['gross_revenue', 'tax_amount', 'net_revenue_before_tax', 'net_revenue_after_tax',
                     'cogs', 'returned_cogs', 'refund_amount', 'payment_fee', 'cm'] %}

WITH
  dim_products AS (
    SELECT GENERATE_UUID() AS dim_product_id
          ,DATE(order_date) AS date
          ,country_id
          ,country
          ,product_category
          ,product_name
          {% for count_field in count_fields -%}
          ,COUNT({{ count_field }}) AS nb_{{ count_field }}
          {% endfor -%}
          {% for avg_field in avg_fields -%}
          ,ROUND(AVG({{ avg_field }}), 2) AS avg_{{ avg_field }}
          {% endfor -%}
          {% for sum_field in sum_fields -%}
          ,ROUND(SUM({{ sum_field }}), 2) AS total_{{ sum_field }}
          {% endfor %}
      FROM {{ ref('fct_orders') }}
      {%- if is_incremental() %}
      WHERE DATE(order_date) >= (SELECT DATE_SUB(MAX(date), INTERVAL 3 DAY) FROM {{ this }})
      {%- endif %}
      GROUP BY date
              ,country_id
              ,country
              ,product_category
              ,product_name)

  SELECT *
    FROM dim_products