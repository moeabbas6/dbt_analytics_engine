




select
    
    
    
    count(distinct country_id) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct country_id) = 1


