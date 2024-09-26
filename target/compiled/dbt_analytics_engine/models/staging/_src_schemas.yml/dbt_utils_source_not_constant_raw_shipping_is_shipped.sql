




select
    
    
    
    count(distinct is_shipped) as filler_column

from `moes-dbt-layer`.`dae_sources`.`shipping`

  

having count(distinct is_shipped) = 1


