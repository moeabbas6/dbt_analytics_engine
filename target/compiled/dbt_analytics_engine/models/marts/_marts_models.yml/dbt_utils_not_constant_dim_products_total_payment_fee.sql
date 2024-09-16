




select
    
    
    
    count(distinct total_payment_fee) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_payment_fee) = 1


