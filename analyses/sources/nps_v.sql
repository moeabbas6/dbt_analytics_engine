WITH 
  orders AS (
    SELECT order_id
          ,customer_id
          ,order_date
      FROM `moes-dbt-layer.dae_sources.orders`)


  ,shipping AS (
    SELECT order_id
          ,shipping_date
      FROM `moes-dbt-layer.dae_sources.shipping`
      WHERE is_shipped IS TRUE)


  ,returns AS (
    SELECT order_id
          ,return_date
      FROM `moes-dbt-layer.dae_sources.returns`
      WHERE is_returned IS TRUE)


  ,nps_flags AS (
    SELECT order_id
          ,customer_id
          ,order_date
          ,shipping_date
          ,return_date
          ,CASE
            WHEN RAND() < 0.55 THEN TRUE
            ELSE FALSE
            END AS is_nps
      FROM orders
      JOIN shipping USING (order_id)
      LEFT JOIN returns USING (order_id))


  ,nps_data AS (
    SELECT order_id
          ,customer_id
          ,order_date
          ,shipping_date
          ,return_date
          ,is_nps
          ,CASE
            WHEN is_nps = TRUE THEN 
              CASE
                WHEN return_date IS NOT NULL THEN
                  CASE
                    WHEN RAND() < 0.60 THEN CAST(FLOOR(1 + RAND() * 3) AS INT64)
                    WHEN RAND() < 0.85 THEN CAST(FLOOR(4 + RAND() * 3) AS INT64)
                    ELSE CAST(FLOOR(7 + RAND() * 4) AS INT64)
                  END
                ELSE 
                  CASE
                    WHEN RAND() < 0.15 THEN CAST(FLOOR(1 + RAND() * 3) AS INT64)
                    WHEN RAND() < 0.30 THEN CAST(FLOOR(4 + RAND() * 3) AS INT64)
                    ELSE CAST(FLOOR(7 + RAND() * 4) AS INT64)
                  END
              END
            ELSE NULL
            END AS nps_score
          ,CASE
            WHEN is_nps = TRUE THEN DATETIME_ADD(
                                      DATETIME_ADD(
                                        DATETIME_ADD(
                                          DATE_ADD(shipping_date, INTERVAL CAST(FLOOR(2 + RAND() * 5) AS INT64) DAY),
                                          INTERVAL CAST(FLOOR(RAND() * 24) AS INT64) HOUR),
                                        INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) MINUTE),
                                      INTERVAL CAST(FLOOR(RAND() * 60) AS INT64) SECOND)
            ELSE NULL
            END AS nps_date
      FROM nps_flags
      WHERE is_nps IS TRUE)


  ,final AS (
    SELECT order_id
          ,customer_id
          ,is_nps
          ,nps_score
          ,nps_date
          ,DATETIME_ADD(DATETIME_TRUNC(DATETIME_ADD(nps_date, INTERVAL 6 HOUR), HOUR), INTERVAL -MOD(EXTRACT(HOUR FROM nps_date), 6) HOUR) AS _loaded_at
      FROM nps_data)


  SELECT *
  FROM final
  WHERE 1=1
    #AND nps_date <= CURRENT_DATE()