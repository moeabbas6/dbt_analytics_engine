




select
    
    
    
    count(distinct created_at) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`payments`

  

having count(distinct created_at) = 1


