



select
    *
from (select * from `moes-dbt-layer`.`sales`.`fct_orders` where returned_cogs > 0) dbt_subquery

where not(returned_cogs = cogs)

