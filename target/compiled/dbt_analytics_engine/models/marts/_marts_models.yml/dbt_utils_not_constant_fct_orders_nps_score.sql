




select
    
    
    
    count(distinct nps_score) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct nps_score) = 1


