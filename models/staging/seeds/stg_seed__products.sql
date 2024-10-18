

WITH
  seed_products AS (
    SELECT product_category_id
          ,product_category
          ,product_id
          ,product_name
          ,inbound_shipping_cost
          ,product_cost
      FROM {{ ref('seed_products') }})


  SELECT *
    FROM seed_products