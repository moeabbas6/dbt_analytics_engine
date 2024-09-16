



select
    *
from `moes-dbt-layer`.`finance`.`fct_payment_methods`

where not(apple_pay_payment_fees >= 0)

