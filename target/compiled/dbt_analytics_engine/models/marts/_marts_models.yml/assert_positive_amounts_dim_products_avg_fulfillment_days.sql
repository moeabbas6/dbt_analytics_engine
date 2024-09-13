

SELECT avg_fulfillment_days
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE avg_fulfillment_days < 0

