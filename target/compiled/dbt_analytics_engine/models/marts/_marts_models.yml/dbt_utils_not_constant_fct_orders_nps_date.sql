




select
    
    
    
    count(distinct nps_date) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct nps_date) = 1


