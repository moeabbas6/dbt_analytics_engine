




select
    
    
    
    count(distinct nb_return_id) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct nb_return_id) = 1


