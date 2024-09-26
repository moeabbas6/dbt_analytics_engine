




select
    
    
    
    count(distinct sales_sma_250) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries_sma`

  

having count(distinct sales_sma_250) = 1


