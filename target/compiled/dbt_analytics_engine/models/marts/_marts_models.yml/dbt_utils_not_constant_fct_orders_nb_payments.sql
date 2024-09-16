




select
    
    
    
    count(distinct nb_payments) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct nb_payments) = 1


