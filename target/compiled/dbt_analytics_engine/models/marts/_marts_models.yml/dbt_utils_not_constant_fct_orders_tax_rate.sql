




select
    
    
    
    count(distinct tax_rate) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct tax_rate) = 1


