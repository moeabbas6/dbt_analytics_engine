




select
    
    
    
    count(distinct total_refund_amount) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_refund_amount) = 1


