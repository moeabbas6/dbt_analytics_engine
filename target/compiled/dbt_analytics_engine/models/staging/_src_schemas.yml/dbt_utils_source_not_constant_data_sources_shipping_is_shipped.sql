




select
    
    
    
    count(distinct is_shipped) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`shipping`

  

having count(distinct is_shipped) = 1


