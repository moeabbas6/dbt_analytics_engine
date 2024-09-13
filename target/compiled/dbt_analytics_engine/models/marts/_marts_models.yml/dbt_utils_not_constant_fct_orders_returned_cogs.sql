




select
    
    
    
    count(distinct returned_cogs) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct returned_cogs) = 1


