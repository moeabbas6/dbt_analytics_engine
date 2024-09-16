




select
    
    
    
    count(distinct date) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders_timeseries_sma`

  

having count(distinct date) = 1


