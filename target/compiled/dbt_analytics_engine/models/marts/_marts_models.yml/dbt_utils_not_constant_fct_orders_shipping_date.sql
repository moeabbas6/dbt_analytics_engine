




select
    
    
    
    count(distinct shipping_date) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct shipping_date) = 1


