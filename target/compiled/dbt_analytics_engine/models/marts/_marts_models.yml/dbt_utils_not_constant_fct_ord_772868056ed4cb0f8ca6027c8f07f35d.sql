




select
    
    
    
    count(distinct sales_sma_lower_120) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries`

  

having count(distinct sales_sma_lower_120) = 1


