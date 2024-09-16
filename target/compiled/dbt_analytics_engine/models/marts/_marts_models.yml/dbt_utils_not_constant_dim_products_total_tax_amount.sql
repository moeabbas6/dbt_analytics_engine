




select
    
    
    
    count(distinct total_tax_amount) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_tax_amount) = 1


