




select
    
    
    
    count(distinct last_name) as filler_column

from `moes-dbt-layer`.`dae_sources`.`customers`

  

having count(distinct last_name) = 1


