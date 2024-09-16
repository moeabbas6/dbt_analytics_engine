




select
    
    
    
    count(distinct total_net_revenue_after_tax) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_net_revenue_after_tax) = 1


