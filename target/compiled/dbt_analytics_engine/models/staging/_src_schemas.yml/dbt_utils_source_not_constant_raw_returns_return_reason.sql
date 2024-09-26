




select
    
    
    
    count(distinct return_reason) as filler_column

from `moes-dbt-layer`.`dae_sources`.`returns`

  

having count(distinct return_reason) = 1


