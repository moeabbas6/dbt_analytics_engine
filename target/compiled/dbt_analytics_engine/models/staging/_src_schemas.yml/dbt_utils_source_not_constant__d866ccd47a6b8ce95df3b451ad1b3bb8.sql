




select
    
    
    
    count(distinct product_category_id) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`orders`

  

having count(distinct product_category_id) = 1


