




select
    
    
    
    count(distinct total_net_revenue_before_tax) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

  

having count(distinct total_net_revenue_before_tax) = 1


