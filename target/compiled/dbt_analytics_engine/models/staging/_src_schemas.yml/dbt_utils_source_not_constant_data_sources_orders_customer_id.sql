




select
    
    
    
    count(distinct customer_id) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`orders`

  

having count(distinct customer_id) = 1


