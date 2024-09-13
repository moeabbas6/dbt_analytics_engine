

SELECT net_revenue_after_tax
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE net_revenue_after_tax < 0

