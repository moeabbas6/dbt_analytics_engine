{{ config(materialized = 'view') }}


{% set fct_orders_v1 = ref('fct_orders', v=1) %}

SELECT
{{ dbt_utils.star(from=fct_orders_v1, except=["product_id", "product_category_id"]) }}
FROM {{ fct_orders_v1 }}