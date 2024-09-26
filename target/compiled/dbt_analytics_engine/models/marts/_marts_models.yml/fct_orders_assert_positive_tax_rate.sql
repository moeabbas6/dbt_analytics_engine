



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(tax_rate > 0)

