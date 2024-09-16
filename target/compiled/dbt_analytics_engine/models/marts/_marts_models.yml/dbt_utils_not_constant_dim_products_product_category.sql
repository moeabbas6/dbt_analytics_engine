




select
    
    
    
    count(distinct product_category) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct product_category) = 1


