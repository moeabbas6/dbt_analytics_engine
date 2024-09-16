




select
    
    
    
    count(distinct order_id) as filler_column

from `moes-dbt-layer`.`finance`.`fct_payment_methods`

  

having count(distinct order_id) = 1


