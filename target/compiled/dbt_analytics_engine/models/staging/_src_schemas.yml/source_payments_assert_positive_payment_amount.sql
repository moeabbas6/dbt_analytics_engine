



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`payments`

where not(payment_amount > 0)

