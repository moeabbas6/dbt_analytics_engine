




select
    
    
    
    count(distinct sales_sma_upper_250) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries_sma`

  

having count(distinct sales_sma_upper_250) = 1


