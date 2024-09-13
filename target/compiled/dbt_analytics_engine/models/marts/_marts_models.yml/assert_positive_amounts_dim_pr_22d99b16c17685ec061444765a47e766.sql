

SELECT total_net_revenue_after_tax
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE total_net_revenue_after_tax < 0

