




select
    
    
    
    count(distinct product_name) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct product_name) = 1


