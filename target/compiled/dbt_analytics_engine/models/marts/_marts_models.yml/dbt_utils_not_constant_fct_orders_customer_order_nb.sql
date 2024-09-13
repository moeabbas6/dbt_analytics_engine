




select
    
    
    
    count(distinct customer_order_nb) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct customer_order_nb) = 1


