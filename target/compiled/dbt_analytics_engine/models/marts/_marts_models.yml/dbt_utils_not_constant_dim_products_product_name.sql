




select
    
    
    
    count(distinct product_name) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct product_name) = 1


