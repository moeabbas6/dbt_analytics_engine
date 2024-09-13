

SELECT tax_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE tax_amount < 0

