




select
    
    
    
    count(distinct amazon_pay_amount) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_payment_methods`

  

having count(distinct amazon_pay_amount) = 1


