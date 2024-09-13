




select
    
    
    
    count(distinct shipping_id) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`shipping`

  

having count(distinct shipping_id) = 1


