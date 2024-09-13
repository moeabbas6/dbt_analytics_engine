




select
    
    
    
    count(distinct gross_revenue) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct gross_revenue) = 1


