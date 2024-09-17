

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_payments`
  OPTIONS(
      description=""""""
    )
  as WITH
  stg_payments AS (
    SELECT order_id
          ,payment_id
          ,to_hex(md5(cast(coalesce(cast(order_id as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(payment_id as string), '_dbt_utils_surrogate_key_null_') as string))) AS order_payment_id
          ,payment_method
          ,payment_amount AS gross_revenue
          ,payment_country_id AS country_id
          ,payment_status
          ,created_at
      FROM `moes-dbt-layer`.`dae_sources`.`payments`
      WHERE created_at <= CURRENT_DATETIME('America/Toronto')
        AND created_at > CURRENT_DATE - INTERVAL 7 DAY)


  SELECT *
    FROM stg_payments;

