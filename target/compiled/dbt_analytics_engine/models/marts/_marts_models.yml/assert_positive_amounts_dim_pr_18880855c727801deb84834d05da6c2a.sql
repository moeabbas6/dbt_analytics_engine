

SELECT total_net_revenue_before_tax
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE total_net_revenue_before_tax < 0

