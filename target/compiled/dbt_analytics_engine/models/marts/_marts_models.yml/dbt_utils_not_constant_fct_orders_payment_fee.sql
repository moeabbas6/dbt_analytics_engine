




select
    
    
    
    count(distinct payment_fee) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct payment_fee) = 1


