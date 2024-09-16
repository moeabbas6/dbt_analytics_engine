




select
    
    
    
    count(distinct product_category) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct product_category) = 1


