

SELECT tax_rate
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_taxes`
  WHERE tax_rate < 0

