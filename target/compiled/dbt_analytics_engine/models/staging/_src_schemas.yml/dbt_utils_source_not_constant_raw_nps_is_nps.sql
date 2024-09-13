




select
    
    
    
    count(distinct is_nps) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`nps`

  

having count(distinct is_nps) = 1


