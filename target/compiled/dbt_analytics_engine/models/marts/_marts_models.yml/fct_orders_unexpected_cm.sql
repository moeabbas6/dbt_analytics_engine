



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(cm < gross_revenue)

