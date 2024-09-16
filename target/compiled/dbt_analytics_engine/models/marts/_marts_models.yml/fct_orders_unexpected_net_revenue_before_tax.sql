



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(net_revenue_before_tax = SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)))

