

SELECT total_payment_fee
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
  WHERE total_payment_fee < 0

