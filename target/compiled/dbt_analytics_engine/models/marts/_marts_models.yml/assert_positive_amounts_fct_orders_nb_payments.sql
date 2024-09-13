

SELECT nb_payments
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE nb_payments < 0

