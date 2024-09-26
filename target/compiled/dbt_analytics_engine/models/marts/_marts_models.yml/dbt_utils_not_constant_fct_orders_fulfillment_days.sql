




select
    
    
    
    count(distinct fulfillment_days) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct fulfillment_days) = 1


