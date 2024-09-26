




select
    
    
    
    count(distinct date) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct date) = 1


