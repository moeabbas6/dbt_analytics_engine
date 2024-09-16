




select
    
    
    
    count(distinct sales) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries_sma`

  

having count(distinct sales) = 1


