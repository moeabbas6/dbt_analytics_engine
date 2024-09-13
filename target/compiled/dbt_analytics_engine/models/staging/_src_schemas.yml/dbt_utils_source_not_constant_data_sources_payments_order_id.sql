




select
    
    
    
    count(distinct order_id) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`payments`

  

having count(distinct order_id) = 1


