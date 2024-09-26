



select
    *
from (select * from `moes-dbt-layer`.`dae_sources`.`shipping` where shipping_amount IS NOT NULL) dbt_subquery

where not(shipping_amount > 0)

