




select
    
    
    
    count(distinct avg_fulfillment_days) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

  

having count(distinct avg_fulfillment_days) = 1


