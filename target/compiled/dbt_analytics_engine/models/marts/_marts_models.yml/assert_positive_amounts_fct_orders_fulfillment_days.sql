

SELECT fulfillment_days
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE fulfillment_days < 0

