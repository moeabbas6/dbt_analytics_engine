

WITH
  order_ids_current_year AS (
    SELECT GENERATE_UUID() AS order_id
          ,DATETIME_ADD(
              DATETIME_ADD(
                DATETIME_ADD(
                  CASE
                    WHEN RAND() < 0.20 THEN DATETIME(TIMESTAMP('2024-01-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                    WHEN RAND() < 0.50 THEN DATETIME(TIMESTAMP('2024-04-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                    WHEN RAND() < 0.70 THEN DATETIME(TIMESTAMP('2024-07-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                    ELSE DATETIME(TIMESTAMP('2024-10-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                  END,
                  INTERVAL CAST(FLOOR(RAND() * 24) AS INT64) HOUR),
                INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) MINUTE),
              INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) SECOND) AS created_at
          ,CASE
            WHEN RAND() < 0.15 THEN 1
            WHEN RAND() < 0.30 THEN 2
            WHEN RAND() < 0.45 THEN 3
            WHEN RAND() < 0.60 THEN 4
            WHEN RAND() < 0.72 THEN 5
            WHEN RAND() < 0.80 THEN 6
            WHEN RAND() < 0.85 THEN 7
            WHEN RAND() < 0.90 THEN 8
            WHEN RAND() < 0.95 THEN 9
            ELSE 10
          END AS payment_country_id
      FROM UNNEST(GENERATE_ARRAY(1, 210000)))


  ,order_ids_previous_year AS (
    SELECT GENERATE_UUID() AS order_id
          ,DATETIME_ADD(
              DATETIME_ADD(
                DATETIME_ADD(
                  CASE
                    WHEN RAND() < 0.25 THEN DATETIME(TIMESTAMP('2023-01-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                    WHEN RAND() < 0.55 THEN DATETIME(TIMESTAMP('2023-04-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                    WHEN RAND() < 0.75 THEN DATETIME(TIMESTAMP('2023-07-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                    ELSE DATETIME(TIMESTAMP('2023-10-01 00:00:00') + INTERVAL CAST(FLOOR(RAND() * 90) AS INT64) DAY)
                  END,
                  INTERVAL CAST(FLOOR(RAND() * 24) AS INT64) HOUR),
                INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) MINUTE),
              INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) SECOND) AS created_at
          ,CASE
            WHEN RAND() < 0.10 THEN 1
            WHEN RAND() < 0.22 THEN 2
            WHEN RAND() < 0.37 THEN 3
            WHEN RAND() < 0.55 THEN 4
            WHEN RAND() < 0.67 THEN 5
            WHEN RAND() < 0.77 THEN 6
            WHEN RAND() < 0.85 THEN 7
            WHEN RAND() < 0.90 THEN 8
            WHEN RAND() < 0.94 THEN 9
            ELSE 10
          END AS payment_country_id
      FROM UNNEST(GENERATE_ARRAY(1, 165000)))


  ,order_ids AS (
    SELECT * FROM order_ids_current_year
    UNION ALL
    SELECT * FROM order_ids_previous_year)


  ,payment_ids AS (
    SELECT order_id
          ,created_at
          ,payment_country_id
          ,GENERATE_ARRAY(1, CAST(FLOOR(1 + RAND() * 2) AS INT64)) AS payment_id_array
      FROM order_ids)


  ,order_payments AS (
    SELECT order_id
          ,created_at
          ,payment_country_id
          ,DATETIME_ADD(created_at, INTERVAL (id - 1) * CAST(FLOOR(RAND() * 12) AS INT64) HOUR) AS payment_created_at
          ,id
      FROM payment_ids
          ,UNNEST(payment_id_array) AS id)


  ,payment_methods AS (
    SELECT order_id
          ,id AS payment_id
          ,payment_country_id
          ,payment_created_at AS created_at
          ,CASE
            WHEN RAND() < 0.40 THEN 'stripe'
            WHEN RAND() < 0.63 THEN 'amazon_pay'
            WHEN RAND() < 0.91 THEN 'apple_pay'
            ELSE 'bitcoin'
          END AS payment_method
      FROM order_payments)


  ,final AS (
    SELECT order_id
          ,payment_id
          ,payment_method
          ,ROUND(50 + RAND() * 75) AS payment_amount
          ,payment_country_id
          ,CASE 
            WHEN RAND() < 0.90 THEN 'successful'
            ELSE 'failed'
            END AS payment_status
          ,created_at
          ,DATETIME_ADD(DATETIME_TRUNC(DATETIME_ADD(created_at, INTERVAL 6 HOUR), HOUR), INTERVAL -MOD(EXTRACT(HOUR FROM created_at), 6) HOUR) AS _loaded_at
      FROM payment_methods)


  SELECT *
    FROM final
    WHERE 1=1
      #AND created_at <= CURRENT_DATE