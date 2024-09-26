

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_orders`
  OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 72 hour),
    
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
      FROM `moes-dbt-layer`.`dae_sources`.`orders`
      WHERE order_date <= CURRENT_DATETIME('America/Toronto')
        AND order_date > CURRENT_DATE - INTERVAL 3 DAY)


  SELECT *
    FROM stg_orders;

