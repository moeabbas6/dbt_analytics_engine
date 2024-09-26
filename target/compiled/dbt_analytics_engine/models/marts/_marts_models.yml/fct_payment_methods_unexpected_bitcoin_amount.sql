



select
    *
from `moes-dbt-layer`.`finance`.`fct_payment_methods`

where not(bitcoin_amount >= 0)

