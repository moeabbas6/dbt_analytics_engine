




select
    
    
    
    count(distinct country_id) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct country_id) = 1


