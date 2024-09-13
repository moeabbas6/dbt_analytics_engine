




select
    
    
    
    count(distinct country_id) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_payment_methods`

  

having count(distinct country_id) = 1


