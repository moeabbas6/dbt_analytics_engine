




select
    
    
    
    count(distinct shipping_date) as filler_column

from `moes-dbt-layer`.`dae_sources`.`shipping`

  

having count(distinct shipping_date) = 1


