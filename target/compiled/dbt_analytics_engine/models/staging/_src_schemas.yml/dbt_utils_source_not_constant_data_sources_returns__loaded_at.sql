




select
    
    
    
    count(distinct _loaded_at) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`returns`

  

having count(distinct _loaded_at) = 1


