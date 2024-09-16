



select
    *
from `moes-dbt-layer`.`product`.`dim_products`

where not(total_net_revenue_before_tax > 0)

