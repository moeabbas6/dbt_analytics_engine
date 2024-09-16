



select
    *
from `moes-dbt-layer`.`product`.`dim_products`

where not(total_gross_revenue > 0)

