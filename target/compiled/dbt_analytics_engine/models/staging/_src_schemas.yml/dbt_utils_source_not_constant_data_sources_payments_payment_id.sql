




select
    
    
    
    count(distinct payment_id) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`payments`

  

having count(distinct payment_id) = 1


