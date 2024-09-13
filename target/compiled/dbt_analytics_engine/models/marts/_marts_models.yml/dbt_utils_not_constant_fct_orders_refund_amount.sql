




select
    
    
    
    count(distinct refund_amount) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct refund_amount) = 1


