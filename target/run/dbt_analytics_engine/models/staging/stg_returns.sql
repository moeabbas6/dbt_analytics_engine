

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_returns`
  OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 72 hour),
    
      description=""""""
    )
  as WITH
  stg_returns AS (
    SELECT order_id
          ,return_id
          ,is_returned
          ,return_date
          ,return_reason
      FROM `moes-dbt-layer`.`dae_sources`.`returns`
      WHERE return_date < CURRENT_DATE
        AND return_date > CURRENT_DATE - INTERVAL 3 DAY)


  SELECT *
    FROM stg_returns;

