



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(payment_fee > 0)

