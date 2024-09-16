




select
    
    
    
    count(distinct return_id) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct return_id) = 1


