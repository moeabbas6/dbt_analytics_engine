




select
    
    
    
    count(distinct order_date) as filler_column

from `moes-dbt-layer`.`finance`.`fct_payment_methods`

  

having count(distinct order_date) = 1


