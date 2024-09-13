

SELECT stripe_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_payment_methods`
  WHERE stripe_amount < 0

