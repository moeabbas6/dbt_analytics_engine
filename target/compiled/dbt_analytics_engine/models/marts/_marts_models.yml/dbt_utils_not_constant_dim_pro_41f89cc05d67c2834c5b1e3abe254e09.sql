




select
    
    
    
    count(distinct total_net_revenue_before_tax) as filler_column

from `moes-dbt-layer`.`product`.`dim_products`

  

having count(distinct total_net_revenue_before_tax) = 1


