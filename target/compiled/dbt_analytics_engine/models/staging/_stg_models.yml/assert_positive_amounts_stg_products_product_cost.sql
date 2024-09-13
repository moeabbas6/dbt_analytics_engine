

SELECT product_cost
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_products`
  WHERE product_cost < 0

