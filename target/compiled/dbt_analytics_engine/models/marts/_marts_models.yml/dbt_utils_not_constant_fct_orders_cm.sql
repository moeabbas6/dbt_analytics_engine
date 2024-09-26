




select
    
    
    
    count(distinct cm) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct cm) = 1


