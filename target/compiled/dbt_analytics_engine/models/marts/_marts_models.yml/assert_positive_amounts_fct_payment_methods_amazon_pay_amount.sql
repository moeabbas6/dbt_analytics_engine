

SELECT amazon_pay_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_payment_methods`
  WHERE amazon_pay_amount < 0

