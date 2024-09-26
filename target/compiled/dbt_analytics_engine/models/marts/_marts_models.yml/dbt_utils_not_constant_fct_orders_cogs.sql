




select
    
    
    
    count(distinct cogs) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct cogs) = 1


