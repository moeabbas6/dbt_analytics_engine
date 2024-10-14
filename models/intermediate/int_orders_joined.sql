

WITH
  orders_customers AS (
    SELECT *
      FROM {{ ref('int_orders_customers_joined') }})


  ,nps_returns_shipping AS (
    SELECT *
      FROM {{ ref('int_nps_returns_shipping_joined') }})


  ,final AS (
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
      FROM orders_customers
      LEFT JOIN nps_returns_shipping USING (order_id))


  SELECT *
    FROM final