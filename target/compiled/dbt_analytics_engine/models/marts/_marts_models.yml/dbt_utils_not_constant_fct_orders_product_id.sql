




select
    
    
    
    count(distinct product_id) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct product_id) = 1


