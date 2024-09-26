




select
    
    
    
    count(distinct shipping_id) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct shipping_id) = 1


