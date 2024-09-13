



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_payment_methods`

where not(apple_pay_amount >= 0)

