




select
    
    
    
    count(distinct total_returned_cogs) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

  

having count(distinct total_returned_cogs) = 1


