

WITH
  int_customers_orders_products_joined AS (
    SELECT *
      FROM {{ ref('int_customers_orders_products_joined') }})


  ,int_nps_returns_shipping_joined AS (
    SELECT *
      FROM {{ ref('int_nps_returns_shipping_joined') }})


  ,int_order_lvl_joined AS (
    SELECT product_category_id
          ,product_id
          ,order_id
          ,customer_id
          ,first_order_date
          ,customer_order_nb
          ,order_status
          ,order_date
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
      FROM int_customers_orders_products_joined
      LEFT JOIN int_nps_returns_shipping_joined USING (order_id))


  SELECT *
    FROM int_order_lvl_joined