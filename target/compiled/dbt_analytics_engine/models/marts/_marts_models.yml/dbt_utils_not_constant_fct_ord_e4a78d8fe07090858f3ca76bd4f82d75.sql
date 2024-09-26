




select
    
    
    
    count(distinct sales_sma_lower_30) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries_sma`

  

having count(distinct sales_sma_lower_30) = 1


