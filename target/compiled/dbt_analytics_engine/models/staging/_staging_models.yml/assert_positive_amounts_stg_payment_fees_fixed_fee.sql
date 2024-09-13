

SELECT fixed_fee
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_payment_fees`
  WHERE fixed_fee < 0

