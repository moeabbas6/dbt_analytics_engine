



select
    *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`

where not(fulfillment_days = DATE_DIFF(shipping_date, order_date, DAY))

