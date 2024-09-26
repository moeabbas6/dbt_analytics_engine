WITH
  stg_customers AS (
    SELECT customer_id
          ,first_name
          ,last_name
      FROM `moes-dbt-layer`.`dae_sources`.`customers`)


  SELECT *
    FROM stg_customers