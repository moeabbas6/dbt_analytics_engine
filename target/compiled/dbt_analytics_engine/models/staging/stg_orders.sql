WITH
  stg_orders AS (
    SELECT order_id
          ,customer_id
          ,order_status
          ,order_date
          ,product_category_id
          ,product_id
      FROM `moes-dbt-layer`.`dae_sources`.`orders`
      WHERE order_date <= CURRENT_DATETIME('America/Toronto')
        )


  SELECT *
    FROM stg_orders