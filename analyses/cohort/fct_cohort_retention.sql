

WITH 
  customer_cohorts AS (
    SELECT customer_id
          ,DATE(DATE_TRUNC(first_order_date, MONTH)) AS cohort_month
      FROM {{ ref('fct_orders') }}
      GROUP BY customer_id
              ,cohort_month)


  ,orders_with_cohort AS (
      SELECT customer_id
            ,order_id
            ,DATE(DATE_TRUNC(order_date, MONTH)) AS order_month
            ,cohort_month
        FROM {{ ref('fct_orders') }}
        JOIN customer_cohorts USING (customer_id))


  ,cohort_activity AS (
      SELECT cohort_month
            ,order_month
            ,COUNT(DISTINCT customer_id) AS active_customers
        FROM orders_with_cohort
        GROUP BY cohort_month
                ,order_month)


  ,cohort_sizes AS (
      SELECT cohort_month
            ,COUNT(DISTINCT customer_id) AS cohort_size
        FROM customer_cohorts
        GROUP BY cohort_month)


  ,cohort_retention AS (
      SELECT cohort_month
            ,order_month
            ,active_customers
            ,cohort_size
            ,active_customers / cohort_size AS retention_rate
        FROM cohort_activity ca
        JOIN cohort_sizes cs USING (cohort_month))


  ,final AS (
    SELECT cohort_month
           ,order_month
           ,active_customers
           ,cohort_size
           ,retention_rate
      FROM cohort_retention
      ORDER BY cohort_month, order_month)


  SELECT *
    FROM final