

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_shipping`
  OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 72 hour),
    
      description=""""""
    )
  as WITH
  stg_shipping AS (
    SELECT order_id
          ,shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
      FROM `moes-dbt-layer`.`dae_sources`.`shipping`
      WHERE shipping_date < CURRENT_DATE
        AND shipping_date > CURRENT_DATE - INTERVAL 3 DAY)


  SELECT *
    FROM stg_shipping;

