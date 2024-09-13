

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_shipping`
  OPTIONS(
      description=""""""
    )
  as WITH
  stg_shipping AS (
    SELECT order_id
          ,shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
      FROM `moes-dbt-layer`.`dbt_analytics_engine_sources`.`shipping`
      WHERE shipping_date <= CURRENT_DATETIME('America/Toronto')
         OR shipping_date IS NULL)


  SELECT *
    FROM stg_shipping;

