



select
    *
from `moes-dbt-layer`.`finance`.`fct_payment_methods`

where not(bitcoin_payment_fees >= 0)

