




select
    
    
    
    count(distinct returned_cogs) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct returned_cogs) = 1


