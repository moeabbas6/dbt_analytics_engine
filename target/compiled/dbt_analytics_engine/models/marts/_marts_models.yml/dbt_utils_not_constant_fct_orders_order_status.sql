




select
    
    
    
    count(distinct order_status) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct order_status) = 1


