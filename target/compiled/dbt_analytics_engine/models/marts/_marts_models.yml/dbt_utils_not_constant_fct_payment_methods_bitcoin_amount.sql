




select
    
    
    
    count(distinct bitcoin_amount) as filler_column

from `moes-dbt-layer`.`finance`.`fct_payment_methods`

  

having count(distinct bitcoin_amount) = 1


