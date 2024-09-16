




select
    
    
    
    count(distinct apple_pay_amount) as filler_column

from `moes-dbt-layer`.`finance`.`fct_payment_methods`

  

having count(distinct apple_pay_amount) = 1


