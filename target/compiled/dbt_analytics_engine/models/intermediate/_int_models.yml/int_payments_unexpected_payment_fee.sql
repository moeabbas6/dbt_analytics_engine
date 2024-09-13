



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payments`

where not(payment_fee = ROUND((gross_revenue * (percentage_fee / 100)) + fixed_fee, 2))

