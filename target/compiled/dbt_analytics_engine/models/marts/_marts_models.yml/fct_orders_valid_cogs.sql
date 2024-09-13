



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

where not(cogs < gross_revenue)

