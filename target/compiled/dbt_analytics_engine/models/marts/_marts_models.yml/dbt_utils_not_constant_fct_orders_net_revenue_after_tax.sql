




select
    
    
    
    count(distinct net_revenue_after_tax) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct net_revenue_after_tax) = 1


