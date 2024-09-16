




select
    
    
    
    count(distinct total_gross_revenue) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_gross_revenue) = 1


