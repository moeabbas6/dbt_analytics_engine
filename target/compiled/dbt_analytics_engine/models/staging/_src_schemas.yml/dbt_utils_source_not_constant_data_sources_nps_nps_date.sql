




select
    
    
    
    count(distinct nps_date) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`nps`

  

having count(distinct nps_date) = 1


