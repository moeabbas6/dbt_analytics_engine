WITH
  stg_nps AS (
    SELECT order_id
          ,customer_id
          ,is_nps
          ,nps_score
          ,nps_date
      FROM `moes-dbt-layer`.`dae_sources`.`nps`
      WHERE nps_date <= CURRENT_DATETIME('America/Toronto')
        AND nps_date > CURRENT_DATE - INTERVAL 7 DAY)


  SELECT *
    FROM stg_nps