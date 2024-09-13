

SELECT total_payment_fees
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_payment_methods`
  WHERE total_payment_fees < 0

