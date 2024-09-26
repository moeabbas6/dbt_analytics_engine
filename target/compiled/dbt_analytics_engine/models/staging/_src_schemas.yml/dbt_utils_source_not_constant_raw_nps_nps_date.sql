




select
    
    
    
    count(distinct nps_date) as filler_column

from `moes-dbt-layer`.`dae_sources`.`nps`

  

having count(distinct nps_date) = 1


