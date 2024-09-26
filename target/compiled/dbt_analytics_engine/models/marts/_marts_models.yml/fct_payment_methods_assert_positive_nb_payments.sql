



select
    *
from `moes-dbt-layer`.`finance`.`fct_payment_methods`

where not(nb_payments > 0)

