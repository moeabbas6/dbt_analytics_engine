

SELECT total_cogs
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE total_cogs < 0

