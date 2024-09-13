




select
    
    
    
    count(distinct payment_fee) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct payment_fee) = 1


