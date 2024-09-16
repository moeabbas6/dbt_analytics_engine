



select
    *
from (select * from `moes-dbt-layer`.`sales`.`fct_orders` where refund_amount > 0) dbt_subquery

where not(refund_amount = (gross_revenue - shipping_amount))

