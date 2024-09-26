




select
    
    
    
    count(distinct gross_revenue) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct gross_revenue) = 1


