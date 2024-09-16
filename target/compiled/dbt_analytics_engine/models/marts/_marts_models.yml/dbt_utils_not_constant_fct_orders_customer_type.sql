




select
    
    
    
    count(distinct customer_type) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct customer_type) = 1


