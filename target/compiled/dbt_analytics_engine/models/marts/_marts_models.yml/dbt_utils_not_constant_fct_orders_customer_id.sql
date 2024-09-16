




select
    
    
    
    count(distinct customer_id) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct customer_id) = 1


