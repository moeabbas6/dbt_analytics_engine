




select
    
    
    
    count(distinct country) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct country) = 1


