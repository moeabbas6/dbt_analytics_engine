

SELECT inbound_shipping_cost
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_order_lvl_joined`
  WHERE inbound_shipping_cost = 0

