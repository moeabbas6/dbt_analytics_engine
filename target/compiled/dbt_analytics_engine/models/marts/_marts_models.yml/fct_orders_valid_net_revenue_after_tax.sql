



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

where not(net_revenue_after_tax < gross_revenue)

