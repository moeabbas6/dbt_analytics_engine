




select
    
    
    
    count(distinct sales_sma_14) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries`

  

having count(distinct sales_sma_14) = 1


