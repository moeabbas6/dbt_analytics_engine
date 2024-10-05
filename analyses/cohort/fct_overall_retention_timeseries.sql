

WITH 
  cohort_retention AS (
    SELECT order_month AS date
          ,AVG(retention_rate) AS avg_retention_rate
      FROM {{ ref('fct_cohort_retention') }}
      GROUP BY date
      ORDER BY date)

  SELECT *
    FROM cohort_retention