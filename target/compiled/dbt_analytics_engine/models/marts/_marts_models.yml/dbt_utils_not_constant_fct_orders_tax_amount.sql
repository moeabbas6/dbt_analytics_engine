




select
    
    
    
    count(distinct tax_amount) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct tax_amount) = 1


