



select
    *
from `moes-dbt-layer`.`seeds`.`seed_products`

where not(product_cost > 0)

