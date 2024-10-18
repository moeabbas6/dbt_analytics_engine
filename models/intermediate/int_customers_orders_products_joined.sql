

WITH
  stg_raw__orders AS (
    SELECT *
      FROM {{ ref('stg_raw__orders') }})


  ,stg_raw__customers AS (
    SELECT *
      FROM {{ ref('stg_raw__customers') }})


  ,stg_seed__products AS (
    SELECT *
      FROM {{ ref('stg_seed__products') }})


  ,int_orders_customers AS (
    SELECT *
      FROM stg_raw__orders
      LEFT JOIN stg_raw__customers USING (customer_id))


  ,customers_window_functions AS (
    SELECT customer_id
          ,order_id
          ,MIN(DATE(order_date)) OVER (PARTITION BY customer_id) AS first_order_date
          ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_order_nb
      FROM int_orders_customers)


  ,int_customers_orders_products_joined AS (
    SELECT order_id
          ,order_status
          ,order_date
          ,customer_id
          ,first_order_date
          ,customer_order_nb
          ,product_category_id
          ,product_category
          ,product_id
          ,product_name
          ,inbound_shipping_cost
          ,product_cost
      FROM int_orders_customers
      LEFT JOIN customers_window_functions USING (order_id, customer_id)
      LEFT JOIN stg_seed__products USING (product_category_id, product_id))


  SELECT *
    FROM int_customers_orders_products_joined