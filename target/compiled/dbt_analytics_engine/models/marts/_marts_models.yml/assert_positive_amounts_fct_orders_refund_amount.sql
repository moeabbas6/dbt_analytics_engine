

SELECT refund_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE refund_amount < 0

