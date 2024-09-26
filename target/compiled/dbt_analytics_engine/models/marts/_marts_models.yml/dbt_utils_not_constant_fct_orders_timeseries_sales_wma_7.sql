




select
    
    
    
    count(distinct sales_wma_7) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries`

  

having count(distinct sales_wma_7) = 1


