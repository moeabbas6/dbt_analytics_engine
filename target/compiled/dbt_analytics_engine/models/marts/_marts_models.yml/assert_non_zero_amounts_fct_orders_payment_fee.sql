

SELECT payment_fee
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE payment_fee = 0

