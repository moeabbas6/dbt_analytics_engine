



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

where not(net_revenue_after_tax = SAFE_DIVIDE(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), (1 + SAFE_DIVIDE(tax_rate, 100))))

