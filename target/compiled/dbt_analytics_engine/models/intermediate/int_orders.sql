WITH
  stg_orders AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_orders`)


  ,stg_customers AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_customers`)


  ,stg_shipping AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_shipping`)


  ,stg_returns AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_returns`)


  ,stg_nps AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_nps`)


  ,stg_products AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_products`)


  ,final AS (
    SELECT product_category_id
          ,product_id
          ,order_id
          ,customer_id
          ,order_status
          ,order_date
          ,first_name
          ,last_name
          ,shipping_id
          ,COALESCE(is_shipped, FALSE) AS is_shipped
          ,shipping_date
          ,shipping_amount
          ,return_id
          ,COALESCE(is_returned, FALSE) AS is_returned
          ,return_date
          ,return_reason
          ,COALESCE(is_nps, FALSE) AS is_nps
          ,nps_score
          ,nps_date
          ,product_category
          ,product_name
          ,inbound_shipping_cost
          ,product_cost
      FROM stg_orders
      LEFT JOIN stg_customers USING (customer_id)
      LEFT JOIN stg_shipping USING (order_id)
      LEFT JOIN stg_returns USING (order_id)
      LEFT JOIN stg_nps USING (order_id, customer_id)
      LEFT JOIN stg_products USING (product_category_id, product_id))


  SELECT *
    FROM final