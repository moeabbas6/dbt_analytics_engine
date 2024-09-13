

SELECT total_gross_revenue
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE total_gross_revenue < 0

