




select
    
    
    
    count(distinct first_name) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`customers`

  

having count(distinct first_name) = 1


