




select
    
    
    
    count(distinct last_name) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct last_name) = 1


