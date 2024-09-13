




select
    
    
    
    count(distinct order_date) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`orders`

  

having count(distinct order_date) = 1


