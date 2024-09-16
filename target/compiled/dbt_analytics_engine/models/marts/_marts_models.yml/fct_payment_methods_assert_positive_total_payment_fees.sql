



select
    *
from `moes-dbt-layer`.`finance`.`fct_payment_methods`

where not(total_payment_fees > 0)

