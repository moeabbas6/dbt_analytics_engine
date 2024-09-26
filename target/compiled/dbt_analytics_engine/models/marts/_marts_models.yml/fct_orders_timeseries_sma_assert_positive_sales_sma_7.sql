



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders_timeseries_sma`

where not(sales_sma_7 > 0)

