




select
    
    
    
    count(distinct cm) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct cm) = 1


