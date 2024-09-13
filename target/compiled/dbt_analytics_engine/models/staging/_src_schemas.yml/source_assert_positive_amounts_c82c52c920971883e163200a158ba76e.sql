

SELECT payment_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_sources`.`payments`
  WHERE payment_amount < 0

