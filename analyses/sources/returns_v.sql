WITH
  shipping AS (
    SELECT order_id
          ,is_shipped
          ,shipping_date
      FROM `moes-dbt-layer.dae_sources.shipping`
      WHERE is_shipped IS TRUE
      GROUP BY ALL)


  ,return_flags AS (
    SELECT order_id
          ,is_shipped
          ,shipping_date
          ,CASE
            WHEN is_shipped = TRUE AND shipping_date IS NOT NULL AND RAND() < 0.12 THEN TRUE
            ELSE FALSE
          END AS is_returned
      FROM shipping)


  ,transformation AS (
    SELECT order_id
          ,IF(is_returned IS TRUE, GENERATE_UUID(), NULL) AS return_id
          ,is_returned
          ,CASE 
              WHEN is_returned = TRUE THEN 
                  CASE 
                      WHEN EXTRACT(DAYOFWEEK FROM DATE_ADD(shipping_date, INTERVAL CAST(FLOOR(7 + RAND() * 14) AS INT64) DAY)) = 1 
                      THEN DATETIME_ADD(
                             DATETIME_ADD(
                               DATETIME_ADD(
                                 DATE_ADD(DATE_ADD(shipping_date, INTERVAL CAST(FLOOR(7 + RAND() * 14) AS INT64) DAY), INTERVAL 1 DAY),
                                 INTERVAL CAST(FLOOR(RAND() * 24) AS INT64) HOUR),
                               INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) MINUTE),
                             INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) SECOND)
                      ELSE DATETIME_ADD(
                             DATETIME_ADD(
                               DATETIME_ADD(
                                 DATE_ADD(shipping_date, INTERVAL CAST(FLOOR(7 + RAND() * 14) AS INT64) DAY),
                                 INTERVAL CAST(FLOOR(RAND() * 24) AS INT64) HOUR),
                               INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) MINUTE),
                             INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) SECOND)
                  END
              ELSE NULL
            END AS return_date
          ,CASE
              WHEN is_returned = TRUE THEN 
                  CASE
                      WHEN RAND() < 0.25 THEN 'Not as Described'
                      WHEN RAND() < 0.50 THEN 'Compatibility Issues'
                      WHEN RAND() < 0.75 THEN 'Quality Concerns'
                      ELSE 'Technical Difficulties'
                  END
              ELSE NULL
            END AS return_reason
      FROM return_flags
      WHERE is_returned IS TRUE)


  ,final AS (
    SELECT *
          ,CASE
              WHEN return_date IS NOT NULL THEN 
                DATETIME_ADD(DATETIME_TRUNC(DATETIME_ADD(return_date, INTERVAL 6 HOUR), HOUR), INTERVAL -MOD(EXTRACT(HOUR FROM return_date), 6) HOUR)
              ELSE NULL
          END AS _loaded_at
      FROM transformation)

  SELECT *
    FROM final
    WHERE 1=1