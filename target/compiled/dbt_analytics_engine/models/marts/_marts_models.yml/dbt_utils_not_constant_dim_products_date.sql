




select
    
    
    
    count(distinct date) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

  

having count(distinct date) = 1


