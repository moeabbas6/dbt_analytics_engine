




select
    
    
    
    count(distinct product_name) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

  

having count(distinct product_name) = 1


