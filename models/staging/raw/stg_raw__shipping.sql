

WITH
  stg_raw__shipping AS (
    SELECT order_id
          ,shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
      FROM {{ source("raw", "shipping")}}
      WHERE shipping_date < CURRENT_DATE
        {% if target.name != 'prod' -%}
        AND shipping_date > CURRENT_DATE - INTERVAL 7 DAY
        {%- endif %})


  SELECT *
    FROM stg_raw__shipping