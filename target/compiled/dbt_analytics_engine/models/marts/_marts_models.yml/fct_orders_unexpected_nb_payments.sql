



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(nb_payments > 0)

