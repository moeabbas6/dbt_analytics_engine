

WITH
  stg_orders AS (
    SELECT *
      FROM {{ ref('stg_raw__orders') }})


  ,stg_customers AS (
    SELECT *
      FROM {{ ref('stg_raw__customers') }})


  ,stg_products AS (
    SELECT *
      FROM {{ ref('stg_seed__products') }})


  ,orders_customers AS (
    SELECT *
      FROM stg_orders
      LEFT JOIN stg_customers USING (customer_id))


  ,customers_window_functions AS (
    SELECT customer_id
          ,order_id
          ,MIN(DATE(order_date)) OVER (PARTITION BY customer_id) AS first_order_date
          ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_order_nb
      FROM orders_customers)


  ,joins AS (
    SELECT *
      FROM orders_customers
      LEFT JOIN customers_window_functions USING (order_id, customer_id)
      LEFT JOIN stg_products USING (product_category_id, product_id))


  ,final AS (
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
      FROM joins)


  SELECT *
    FROM final