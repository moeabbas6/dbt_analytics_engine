

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_products`
  OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 72 hour),
    
      description=""""""
    )
  as WITH
  stg_products AS (
    SELECT product_category_id
          ,product_category
          ,product_id
          ,product_name
          ,inbound_shipping_cost
          ,product_cost
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`seed_products`)


  SELECT *
    FROM stg_products;

