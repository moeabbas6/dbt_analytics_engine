




select
    
    
    
    count(distinct avg_nps_score) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

  

having count(distinct avg_nps_score) = 1


