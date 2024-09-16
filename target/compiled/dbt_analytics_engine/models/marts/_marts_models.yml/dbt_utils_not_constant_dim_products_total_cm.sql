




select
    
    
    
    count(distinct total_cm) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_cm) = 1


