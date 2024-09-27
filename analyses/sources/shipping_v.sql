WITH
  payments AS (
    SELECT order_id
          ,MAX(created_at) AS created_at
    FROM `moes-dbt-layer.dae_sources.payments`
    GROUP BY order_id)


  ,shipping_flags AS (
    SELECT order_id
          ,created_at
          ,CASE 
            WHEN RAND() < 0.925 THEN TRUE
            ELSE FALSE
          END AS is_shipped
      FROM payments)


  ,shipping_data AS (
    SELECT order_id
          ,created_at
          ,is_shipped
          ,CASE 
            WHEN is_shipped = TRUE THEN 
              CASE 
                WHEN EXTRACT(DAYOFWEEK FROM DATE_ADD(created_at, INTERVAL CAST(FLOOR(2 + RAND() * 4) AS INT64) DAY)) = 1 
                THEN DATETIME_ADD(
                       DATETIME_ADD(
                         DATETIME_ADD(
                           DATE_ADD(DATE_ADD(created_at, INTERVAL CAST(FLOOR(2 + RAND() * 4) AS INT64) DAY), INTERVAL 1 DAY),
                           INTERVAL CAST(FLOOR(RAND() * 24) AS INT64) HOUR),
                         INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) MINUTE),
                       INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) SECOND)
                ELSE DATETIME_ADD(
                       DATETIME_ADD(
                         DATETIME_ADD(
                           DATE_ADD(created_at, INTERVAL CAST(FLOOR(2 + RAND() * 4) AS INT64) DAY),
                           INTERVAL CAST(FLOOR(RAND() * 24) AS INT64) HOUR),
                         INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) MINUTE),
                       INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) SECOND)
              END
            ELSE NULL
            END AS shipping_date
          ,CASE
            WHEN is_shipped = TRUE THEN 
              CASE 
                WHEN RAND() < 0.33 THEN 3.99
                WHEN RAND() < 0.66 THEN 4.99
                ELSE 5.99
              END
            ELSE NULL
            END AS shipping_amount
      FROM shipping_flags)


  ,final AS (
    SELECT order_id
          ,IF(is_shipped IS TRUE, GENERATE_UUID(), NULL) AS shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
          ,CASE
              WHEN shipping_date IS NOT NULL THEN 
                DATETIME_ADD(DATETIME_TRUNC(DATETIME_ADD(shipping_date, INTERVAL 6 HOUR), HOUR), INTERVAL -MOD(EXTRACT(HOUR FROM shipping_date), 6) HOUR)
              ELSE NULL
          END AS _loaded_at
      FROM shipping_data)

  
  SELECT *
    FROM final;