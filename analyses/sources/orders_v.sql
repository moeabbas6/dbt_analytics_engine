WITH
  payments AS (
    SELECT order_id
          ,MAX(created_at) AS order_date
          ,CASE
            WHEN COUNTIF(payment_status = 'failed') > 0 THEN 'failed'
            ELSE 'completed'
          END AS order_status
      FROM `moes-dbt-layer.zzz_sources.payments`
      GROUP BY order_id)


  ,customers AS (
    SELECT customer_id
          ,ROW_NUMBER() OVER (ORDER BY RAND()) AS rn
      FROM `moes-dbt-layer.zzz_sources.customers`)


  ,customer_replicated AS (
    SELECT customer_id
          ,ROW_NUMBER() OVER (ORDER BY RAND()) AS rn
      FROM customers
          ,UNNEST(GENERATE_ARRAY(1, 10)) AS x)


  ,order_numbers AS (
    SELECT order_id
          ,order_date
          ,order_status
          ,ROW_NUMBER() OVER (ORDER BY order_id) AS rn
      FROM payments)


  ,orders_with_customers AS (
    SELECT o.order_id
          ,o.order_date
          ,o.order_status
          ,c.customer_id
      FROM order_numbers o
      LEFT JOIN customer_replicated c ON o.rn = c.rn)

  
  ,product_assignment AS (
    SELECT order_id
          ,customer_id
          ,order_status
          ,order_date
          ,CASE
            WHEN RAND() < 0.25 THEN 1
            WHEN RAND() < 0.45 THEN 2
            WHEN RAND() < 0.65 THEN 3
            WHEN RAND() < 0.85 THEN 4
            ELSE 5
          END AS product_category_id
      FROM orders_with_customers)


  ,product_assignment_with_ids AS (
    SELECT order_id
          ,customer_id
          ,order_status
          ,order_date
          ,product_category_id
          ,CASE
            WHEN product_category_id = 1 THEN CAST(1 + FLOOR(RAND() * 5) AS INT64)
            WHEN product_category_id = 2 THEN CAST(1 + FLOOR(RAND() * 5) AS INT64)
            WHEN product_category_id = 3 THEN CAST(1 + FLOOR(RAND() * 5) AS INT64)
            WHEN product_category_id = 4 THEN CAST(1 + FLOOR(RAND() * 5) AS INT64)
            ELSE CAST(1 + FLOOR(RAND() * 5) AS INT64)
          END AS product_id
      FROM product_assignment)


  ,final AS (
    SELECT order_id
          ,customer_id
          ,order_status
          ,order_date
          ,product_category_id
          ,product_id
          ,DATETIME_ADD(DATETIME_TRUNC(DATETIME_ADD(order_date, INTERVAL 6 HOUR), HOUR), INTERVAL -MOD(EXTRACT(HOUR FROM order_date), 6) HOUR) AS _loaded_at
      FROM product_assignment_with_ids)


  SELECT *
    FROM final