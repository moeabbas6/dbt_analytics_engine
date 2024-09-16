




select
    
    
    
    count(distinct nps_date) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct nps_date) = 1


