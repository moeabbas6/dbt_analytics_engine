

WITH
  stg_orders AS (
    SELECT order_id
          ,customer_id
          ,order_status
          ,order_date
          ,product_category_id
          ,product_id
      FROM {{ source("raw", "orders")}}
      WHERE order_date <= CURRENT_DATETIME('America/Toronto')
        {% if target.name != 'prod' -%}
        AND order_date > CURRENT_DATE - INTERVAL 3 DAY
        {%- endif %})


  SELECT *
    FROM stg_orders