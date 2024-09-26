




select
    
    
    
    count(distinct nb_order_id) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct nb_order_id) = 1


