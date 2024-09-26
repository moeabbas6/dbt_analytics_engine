




select
    
    
    
    count(distinct customer_id) as filler_column

from `moes-dbt-layer`.`dae_sources`.`nps`

  

having count(distinct customer_id) = 1


