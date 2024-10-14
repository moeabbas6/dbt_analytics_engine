{{ config(
    cluster_by = 'cohort_month'
)}}

WITH 
  customer_cohorts AS (
    SELECT customer_id
          ,DATE_TRUNC(MIN(first_order_date), MONTH) AS cohort_month
      FROM {{ ref('int_customers_orders_products_joined') }}
      GROUP BY customer_id)


  ,orders_with_cohort AS (
    SELECT customer_id
          ,order_id
          ,DATE_TRUNC(order_date, MONTH) AS order_month
          ,cohort_month
          ,DATE_DIFF(DATE_TRUNC(order_date, MONTH), cohort_month, MONTH) AS elapsed_month
      FROM {{ ref('int_customers_orders_products_joined') }}
      JOIN customer_cohorts USING (customer_id)
      WHERE DATE_DIFF(DATE_TRUNC(order_date, MONTH), cohort_month, MONTH) >= 0)

  
  ,cohort_activity AS (
    SELECT cohort_month
          ,elapsed_month
          ,customer_id
      FROM orders_with_cohort
      GROUP BY cohort_month
              ,elapsed_month
              ,customer_id)


  ,customer_last_elapsed_month AS (
    SELECT customer_id
          ,cohort_month
          ,MAX(elapsed_month) AS last_elapsed_month
      FROM cohort_activity
      GROUP BY customer_id
              ,cohort_month)


  ,cohort_elapsed_months AS (
    SELECT cohort_month
          ,elapsed_month
      FROM (SELECT cohort_month
                  ,elapsed_month
              FROM cohort_activity
              GROUP BY cohort_month
                      ,elapsed_month))

  
  ,cohort_sizes AS (
    SELECT cohort_month
          ,COUNT(DISTINCT customer_id) AS cohort_size
      FROM customer_cohorts
      GROUP BY cohort_month)


  ,cohort_cumulative_retention AS (
    SELECT cem.cohort_month
          ,cem.elapsed_month
          ,COUNT(DISTINCT cla.customer_id) AS customers_retained
          ,cs.cohort_size
          ,SAFE_DIVIDE(COUNT(DISTINCT cla.customer_id), cs.cohort_size) AS cumulative_retention_rate
      FROM cohort_elapsed_months cem
      LEFT JOIN customer_last_elapsed_month cla ON cem.cohort_month = cla.cohort_month 
                                               AND cla.last_elapsed_month >= cem.elapsed_month
      JOIN cohort_sizes cs ON cem.cohort_month = cs.cohort_month
      GROUP BY cem.cohort_month
              ,cem.elapsed_month
              ,cs.cohort_size)

  
  ,point_in_time_activity AS (
    SELECT cohort_month
          ,elapsed_month
          ,COUNT(DISTINCT customer_id) AS active_customers
      FROM cohort_activity
      GROUP BY cohort_month
              ,elapsed_month)


  ,point_in_time_retention AS (
    SELECT cohort_month
          ,elapsed_month
          ,active_customers
          ,cohort_size
          ,SAFE_DIVIDE(active_customers, cohort_size) AS point_in_time_retention_rate
      FROM point_in_time_activity
      JOIN cohort_sizes USING(cohort_month))


  ,final_join AS (
    SELECT ctr.cohort_month
          ,ctr.elapsed_month
          ,ctr.customers_retained
          ,SAFE_SUBTRACT(ctr.cohort_size, ctr.customers_retained) AS churned_users
          ,ctr.cohort_size
          ,ctr.cumulative_retention_rate
          ,ptr.active_customers
          ,ptr.point_in_time_retention_rate
      FROM cohort_cumulative_retention ctr
      JOIN point_in_time_retention ptr ON ctr.cohort_month = ptr.cohort_month
                                      AND ctr.elapsed_month = ptr.elapsed_month
      ORDER BY ctr.cohort_month
              ,ctr.elapsed_month)


  ,final AS (
    SELECT {{ dbt_utils.generate_surrogate_key(['cohort_month', 'elapsed_month']) }} AS id
          ,cohort_month
          ,elapsed_month
          ,cohort_size
          ,customers_retained
          ,churned_users
          ,cumulative_retention_rate
          ,active_customers
          ,point_in_time_retention_rate
    FROM final_join)


  SELECT *
    FROM final