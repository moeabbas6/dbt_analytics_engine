WITH
  stg_payment_fees AS (
    SELECT payment_method_id
          ,payment_method
          ,percentage_fee
          ,fixed_fee
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`seed_payment_fees`)


  SELECT *
    FROM stg_payment_fees