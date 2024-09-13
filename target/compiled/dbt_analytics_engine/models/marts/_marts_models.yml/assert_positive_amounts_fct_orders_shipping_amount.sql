

SELECT shipping_amount
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders`
  WHERE shipping_amount < 0

