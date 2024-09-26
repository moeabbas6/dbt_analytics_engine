




select
    
    
    
    count(distinct payment_status) as filler_column

from `moes-dbt-layer`.`dae_sources`.`payments`

  

having count(distinct payment_status) = 1


