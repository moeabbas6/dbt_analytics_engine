




select
    
    
    
    count(distinct is_nps) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct is_nps) = 1


