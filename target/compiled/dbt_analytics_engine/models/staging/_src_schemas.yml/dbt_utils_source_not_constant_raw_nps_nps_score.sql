




select
    
    
    
    count(distinct nps_score) as filler_column

from `moes-dbt-layer`.`dae_sources`.`nps`

  

having count(distinct nps_score) = 1


