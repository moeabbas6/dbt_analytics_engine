



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders_timeseries_sma`

where not(sales_sma_30 > 0)

