




select
    
    
    
    count(distinct sales_sma_lower_60) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries`

  

having count(distinct sales_sma_lower_60) = 1


