




select
    
    
    
    count(distinct is_nps) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct is_nps) = 1


