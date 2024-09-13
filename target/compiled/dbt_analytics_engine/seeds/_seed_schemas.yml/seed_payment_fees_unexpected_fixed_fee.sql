



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev_seeds`.`seed_payment_fees`

where not(fixed_fee > 0)

