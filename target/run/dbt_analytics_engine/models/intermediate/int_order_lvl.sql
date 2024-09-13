

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_order_lvl`
  OPTIONS(
      description=""""""
    )
  as WITH
  stg_orders AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_orders`)


  ,stg_customers AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_customers`)


  ,stg_shipping AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_shipping`)


  ,stg_returns AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_returns`)


  ,stg_nps AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_nps`)


  ,stg_products AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_products`)


  ,final AS (
    SELECT *
      FROM stg_orders
      LEFT JOIN stg_customers USING (customer_id)
      LEFT JOIN stg_shipping USING (order_id)
      LEFT JOIN stg_returns USING (order_id)
      LEFT JOIN stg_nps USING (order_id, customer_id)
      LEFT JOIN stg_products USING (product_category_id, product_id))


  SELECT *
    FROM final;

