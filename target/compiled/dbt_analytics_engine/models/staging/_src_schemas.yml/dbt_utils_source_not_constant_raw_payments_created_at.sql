




select
    
    
    
    count(distinct created_at) as filler_column

from `moes-dbt-layer`.`dae_sources`.`payments`

  

having count(distinct created_at) = 1


