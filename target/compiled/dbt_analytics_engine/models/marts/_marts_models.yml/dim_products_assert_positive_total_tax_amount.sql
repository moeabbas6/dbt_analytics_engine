



select
    *
from `moes-dbt-layer`.`product`.`dim_products`

where not(total_tax_amount > 0)

