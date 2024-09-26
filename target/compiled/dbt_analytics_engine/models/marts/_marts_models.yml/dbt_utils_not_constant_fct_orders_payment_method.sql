




select
    
    
    
    count(distinct payment_method) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct payment_method) = 1


