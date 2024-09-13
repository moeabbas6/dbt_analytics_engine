




select
    
    
    
    count(distinct tax_amount) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct tax_amount) = 1


