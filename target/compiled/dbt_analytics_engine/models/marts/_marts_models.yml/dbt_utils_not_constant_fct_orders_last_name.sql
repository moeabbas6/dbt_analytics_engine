




select
    
    
    
    count(distinct last_name) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct last_name) = 1


