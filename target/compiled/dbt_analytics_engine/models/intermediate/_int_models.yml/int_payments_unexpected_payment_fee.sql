



select
    *
from `moes-dbt-layer`.`staging`.`int_payments`

where not(payment_fee = ROUND((gross_revenue * (percentage_fee / 100)) + fixed_fee, 2))

