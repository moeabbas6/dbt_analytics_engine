




select
    
    
    
    count(distinct country_id) as filler_column

from `moes-dbt-layer`.`finance`.`fct_payment_methods`

  

having count(distinct country_id) = 1


