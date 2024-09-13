




select
    
    
    
    count(distinct return_reason) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`returns`

  

having count(distinct return_reason) = 1


