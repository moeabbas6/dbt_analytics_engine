

SELECT total_gross_revenue
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_payment_methods`
  WHERE total_gross_revenue < 0

