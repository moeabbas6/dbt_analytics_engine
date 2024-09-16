




select
    
    
    
    count(distinct return_date) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct return_date) = 1


