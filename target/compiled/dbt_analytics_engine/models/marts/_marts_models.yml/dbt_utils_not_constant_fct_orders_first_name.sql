




select
    
    
    
    count(distinct first_name) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct first_name) = 1


