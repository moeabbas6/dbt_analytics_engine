




select
    
    
    
    count(distinct is_returned) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`returns`

  

having count(distinct is_returned) = 1


