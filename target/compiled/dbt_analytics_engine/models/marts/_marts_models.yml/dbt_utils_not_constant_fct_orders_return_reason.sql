




select
    
    
    
    count(distinct return_reason) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct return_reason) = 1


