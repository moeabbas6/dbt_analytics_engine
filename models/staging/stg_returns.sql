

WITH
  stg_returns AS (
    SELECT order_id
          ,return_id
          ,is_returned
          ,return_date
          ,return_reason
      FROM {{ source("raw", "returns")}}
      WHERE return_date <= CURRENT_DATETIME('America/Toronto') 
         OR return_date IS NULL)


  SELECT *
    FROM stg_returns