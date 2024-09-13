

WITH
  stg_shipping AS (
    SELECT order_id
          ,shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
      FROM {{ source("raw", "shipping")}}
      WHERE shipping_date <= CURRENT_DATETIME('America/Toronto')
         OR shipping_date IS NULL)


  SELECT *
    FROM stg_shipping