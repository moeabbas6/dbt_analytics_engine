



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

where not(tax_amount > 0)

