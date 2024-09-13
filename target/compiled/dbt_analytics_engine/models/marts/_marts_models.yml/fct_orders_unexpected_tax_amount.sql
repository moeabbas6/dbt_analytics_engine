



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

where not(tax_amount = SAFE_MULTIPLY(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), SAFE_DIVIDE(tax_rate, 100)))

