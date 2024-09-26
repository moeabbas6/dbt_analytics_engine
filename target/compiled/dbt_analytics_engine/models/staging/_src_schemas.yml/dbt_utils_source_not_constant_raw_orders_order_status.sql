




select
    
    
    
    count(distinct order_status) as filler_column

from `moes-dbt-layer`.`dae_sources`.`orders`

  

having count(distinct order_status) = 1


