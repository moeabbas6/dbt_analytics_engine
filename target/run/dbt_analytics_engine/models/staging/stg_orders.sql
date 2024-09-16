

  create or replace view `moes-dbt-layer`.`staging`.`stg_orders`
  OPTIONS(
      description=""""""
    )
  as WITH
  stg_orders AS (
    SELECT order_id
          ,customer_id
          ,order_status
          ,order_date
          ,product_category_id
          ,product_id
      FROM `moes-dbt-layer`.`dbt_analytics_engine_sources`.`orders`
      WHERE order_date <= CURRENT_DATETIME('America/Toronto')
        )


  SELECT *
    FROM stg_orders;

