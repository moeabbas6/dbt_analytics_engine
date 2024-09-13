




select
    
    
    
    count(distinct nb_payments) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

  

having count(distinct nb_payments) = 1


