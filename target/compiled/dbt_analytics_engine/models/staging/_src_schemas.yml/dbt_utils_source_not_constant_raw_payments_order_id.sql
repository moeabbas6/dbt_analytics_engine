




select
    
    
    
    count(distinct order_id) as filler_column

from `moes-dbt-layer`.`dae_sources`.`payments`

  

having count(distinct order_id) = 1


