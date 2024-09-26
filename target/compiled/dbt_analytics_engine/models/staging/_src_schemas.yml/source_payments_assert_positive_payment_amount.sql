



select
    *
from `moes-dbt-layer`.`dae_sources`.`payments`

where not(payment_amount > 0)

