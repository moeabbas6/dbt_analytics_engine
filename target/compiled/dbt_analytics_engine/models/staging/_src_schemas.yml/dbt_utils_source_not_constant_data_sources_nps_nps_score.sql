




select
    
    
    
    count(distinct nps_score) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`nps`

  

having count(distinct nps_score) = 1


