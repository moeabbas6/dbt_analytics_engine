




select
    
    
    
    count(distinct country) as filler_column

from `moes-dbt-layer`.`finance`.`fct_payment_methods`

  

having count(distinct country) = 1


