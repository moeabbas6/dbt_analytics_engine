




select
    
    
    
    count(distinct country) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct country) = 1


