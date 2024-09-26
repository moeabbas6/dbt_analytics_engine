



select
    *
from `moes-dbt-layer`.`product`.`dim_products`

where not(avg_fulfillment_days > 0)

