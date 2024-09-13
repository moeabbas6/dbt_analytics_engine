




select
    
    
    
    count(distinct stripe_amount) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_payment_methods`

  

having count(distinct stripe_amount) = 1


