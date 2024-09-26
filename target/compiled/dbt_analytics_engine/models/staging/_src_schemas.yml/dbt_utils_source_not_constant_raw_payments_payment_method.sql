




select
    
    
    
    count(distinct payment_method) as filler_column

from `moes-dbt-layer`.`dae_sources`.`payments`

  

having count(distinct payment_method) = 1


