




select
    
    
    
    count(distinct total_tax_amount) as filler_column

from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`

  

having count(distinct total_tax_amount) = 1


