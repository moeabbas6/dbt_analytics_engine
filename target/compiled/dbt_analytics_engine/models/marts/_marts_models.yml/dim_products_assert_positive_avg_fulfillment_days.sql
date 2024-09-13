



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

where not(avg_fulfillment_days > 0)

