



select
    *
from `moes-dbt-layer`.`product`.`dim_products`

where not(avg_nps_score > 0)

