

WITH
  stg_nps AS (
    SELECT order_id
          ,customer_id
          ,is_nps
          ,nps_score
          ,nps_date
      FROM {{ source("raw", "nps")}}
      WHERE nps_date <= CURRENT_DATETIME('America/Toronto'))


  SELECT *
    FROM stg_nps