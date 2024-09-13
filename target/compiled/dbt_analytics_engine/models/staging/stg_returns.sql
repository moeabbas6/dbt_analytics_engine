WITH
  stg_returns AS (
    SELECT order_id
          ,return_id
          ,is_returned
          ,return_date
          ,return_reason
      FROM `moes-dbt-layer`.`dbt_analytics_engine_sources`.`returns`
      WHERE return_date <= CURRENT_DATETIME('America/Toronto') 
         OR return_date IS NULL)


  SELECT *
    FROM stg_returns