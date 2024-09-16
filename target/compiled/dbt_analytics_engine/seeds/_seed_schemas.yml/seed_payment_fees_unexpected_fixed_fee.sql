



select
    *
from `moes-dbt-layer`.`seeds`.`seed_payment_fees`

where not(fixed_fee > 0)

