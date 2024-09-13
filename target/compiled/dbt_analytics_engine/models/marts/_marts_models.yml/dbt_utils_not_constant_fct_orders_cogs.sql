




select
    
    
    
    count(distinct cogs) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct cogs) = 1


