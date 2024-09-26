



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders_timeseries`

where not(sales_wma_7 > 0)

