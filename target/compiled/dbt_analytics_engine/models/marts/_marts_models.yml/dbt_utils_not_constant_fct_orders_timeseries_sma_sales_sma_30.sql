




select
    
    
    
    count(distinct sales_sma_30) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders_timeseries_sma`

  

having count(distinct sales_sma_30) = 1


