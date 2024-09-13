




select
    
    
    
    count(distinct bitcoin_payment_fees) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_payment_methods`

  

having count(distinct bitcoin_payment_fees) = 1


