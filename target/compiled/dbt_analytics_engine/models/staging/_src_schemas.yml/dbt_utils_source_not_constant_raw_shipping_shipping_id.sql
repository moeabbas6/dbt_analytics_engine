




select
    
    
    
    count(distinct shipping_id) as filler_column

from `moes-dbt-layer`.`dae_sources`.`shipping`

  

having count(distinct shipping_id) = 1


