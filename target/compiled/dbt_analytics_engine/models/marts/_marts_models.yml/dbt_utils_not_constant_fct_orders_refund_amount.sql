




select
    
    
    
    count(distinct refund_amount) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct refund_amount) = 1


