

SELECT avg_nps_score
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE avg_nps_score < 0

