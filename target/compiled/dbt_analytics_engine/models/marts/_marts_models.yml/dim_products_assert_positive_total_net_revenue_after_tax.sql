



select
    *
from `moes-dbt-layer`.`product`.`dim_products`

where not(total_net_revenue_after_tax > 0)

