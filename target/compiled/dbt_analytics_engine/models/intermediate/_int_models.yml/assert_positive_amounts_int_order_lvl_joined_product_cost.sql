

SELECT product_cost
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_order_lvl_joined`
  WHERE product_cost < 0

