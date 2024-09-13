

SELECT tax_rate
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE tax_rate = 0

