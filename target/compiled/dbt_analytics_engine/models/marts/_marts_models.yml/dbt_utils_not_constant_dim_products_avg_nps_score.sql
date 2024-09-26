




select
    
    
    
    count(distinct avg_nps_score) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct avg_nps_score) = 1


