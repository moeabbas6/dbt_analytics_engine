




select
    
    
    
    count(distinct tax_rate) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct tax_rate) = 1


