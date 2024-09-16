




select
    
    
    
    count(distinct total_returned_cogs) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_returned_cogs) = 1


