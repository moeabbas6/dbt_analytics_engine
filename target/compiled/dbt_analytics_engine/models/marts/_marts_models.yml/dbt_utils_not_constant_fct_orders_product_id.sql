




select
    
    
    
    count(distinct product_id) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct product_id) = 1


