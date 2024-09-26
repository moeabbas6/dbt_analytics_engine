




select
    
    
    
    count(distinct payment_id) as filler_column

from `moes-dbt-layer`.`dae_sources`.`payments`

  

having count(distinct payment_id) = 1


