

SELECT tax_rate
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payment_lvl`
  WHERE tax_rate < 0

