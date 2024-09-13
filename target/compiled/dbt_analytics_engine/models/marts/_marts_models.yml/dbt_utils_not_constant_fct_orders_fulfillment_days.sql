




select
    
    
    
    count(distinct fulfillment_days) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct fulfillment_days) = 1


