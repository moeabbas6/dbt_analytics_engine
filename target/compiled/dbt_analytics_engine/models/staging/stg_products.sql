WITH
  stg_products AS (
    SELECT product_category_id
          ,product_category
          ,product_id
          ,product_name
          ,inbound_shipping_cost
          ,product_cost
      FROM `moes-dbt-layer`.`seeds`.`seed_products`)


  SELECT *
    FROM stg_products