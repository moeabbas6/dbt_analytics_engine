



select
    *
from `moes-dbt-layer`.`seeds`.`seed_products`

where not(inbound_shipping_cost > 0)

