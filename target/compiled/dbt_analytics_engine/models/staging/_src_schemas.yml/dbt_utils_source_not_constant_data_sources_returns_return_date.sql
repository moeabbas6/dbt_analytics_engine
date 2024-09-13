




select
    
    
    
    count(distinct return_date) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`returns`

  

having count(distinct return_date) = 1


