




select
    
    
    
    count(distinct order_status) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`orders`

  

having count(distinct order_status) = 1


