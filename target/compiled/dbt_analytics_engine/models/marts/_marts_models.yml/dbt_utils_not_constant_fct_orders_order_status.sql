




select
    
    
    
    count(distinct order_status) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct order_status) = 1


