



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev_seeds`.`seed_products`

where not(product_cost > 0)

