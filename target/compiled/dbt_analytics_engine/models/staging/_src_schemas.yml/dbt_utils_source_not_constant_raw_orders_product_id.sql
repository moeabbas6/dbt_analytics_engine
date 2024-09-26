




select
    
    
    
    count(distinct product_id) as filler_column

from `moes-dbt-layer`.`dae_sources`.`orders`

  

having count(distinct product_id) = 1


