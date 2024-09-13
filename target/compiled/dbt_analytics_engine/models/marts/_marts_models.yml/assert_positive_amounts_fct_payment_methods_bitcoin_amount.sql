

SELECT bitcoin_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_payment_methods`
  WHERE bitcoin_amount < 0

