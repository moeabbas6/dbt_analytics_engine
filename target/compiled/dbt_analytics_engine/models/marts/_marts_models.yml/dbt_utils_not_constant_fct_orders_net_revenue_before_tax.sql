




select
    
    
    
    count(distinct net_revenue_before_tax) as filler_column

from `moes-dbt-layer`.`sales`.`fct_orders`

  

having count(distinct net_revenue_before_tax) = 1


