




select
    
    
    
    count(distinct is_nps) as filler_column

from `moes-dbt-layer`.`dae_sources`.`nps`

  

having count(distinct is_nps) = 1


