



select
    *
from `moes-dbt-layer`.`sales`.`fct_orders`

where not(fulfillment_days = DATE_DIFF(shipping_date, order_date, DAY))

