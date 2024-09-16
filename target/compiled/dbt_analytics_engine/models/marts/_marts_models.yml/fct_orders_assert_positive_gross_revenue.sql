



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(gross_revenue > 0)

