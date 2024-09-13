

SELECT inbound_shipping_cost
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_products`
  WHERE inbound_shipping_cost = 0

