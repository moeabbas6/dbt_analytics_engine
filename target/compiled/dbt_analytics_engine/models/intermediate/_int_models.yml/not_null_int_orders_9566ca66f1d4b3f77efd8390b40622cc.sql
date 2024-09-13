
    
    



select *
from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_orders`
where product_category_id || '-' || product_id || '-' || order_id || '-' || customer_id || '-' || order_status || '-' || order_date || '-' || first_name || '-' || last_name || '-' || product_category || '-' || product_name || '-' || inbound_shipping_cost || '-' || product_cost is null


