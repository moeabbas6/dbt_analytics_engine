

SELECT total_tax_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE total_tax_amount < 0

