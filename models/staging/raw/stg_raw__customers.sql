

WITH
  stg_raw__customers AS (
    SELECT customer_id
          ,first_name
          ,last_name
      FROM {{ source("raw", "customers")}})


  SELECT *
    FROM stg_raw__customers