



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

where not(total_gross_revenue > 0)

