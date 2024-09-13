

SELECT payment_fee
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payment_lvl_joined`
  WHERE payment_fee = 0

