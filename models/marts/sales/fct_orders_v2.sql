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

{% set fct_orders_v1 = ref('fct_orders', v=1) %}

SELECT
{{ dbt_utils.star(from=fct_orders_v1, except=["product_id", "product_category_id"]) }}
FROM {{ fct_orders_v1 }}
{%- if is_incremental() %}
WHERE order_date >= (SELECT DATE_SUB(MAX(order_date), INTERVAL 3 DAY) FROM {{ this }})
{%- endif -%}