




select
    
    
    
    count(distinct total_cogs) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_cogs) = 1


