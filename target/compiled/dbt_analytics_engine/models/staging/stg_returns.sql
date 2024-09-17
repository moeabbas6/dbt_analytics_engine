WITH
  stg_returns AS (
    SELECT order_id
          ,return_id
          ,is_returned
          ,return_date
          ,return_reason
      FROM `moes-dbt-layer`.`dae_sources`.`returns`
      WHERE return_date < CURRENT_DATE
        AND return_date > CURRENT_DATE - INTERVAL 7 DAY)


  SELECT *
    FROM stg_returns