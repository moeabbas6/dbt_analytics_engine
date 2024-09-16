



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(shipping_amount > 0)

