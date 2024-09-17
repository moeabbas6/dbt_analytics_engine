

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_customers`
  OPTIONS(
      description=""""""
    )
  as WITH
  stg_customers AS (
    SELECT customer_id
          ,first_name
          ,last_name
      FROM `moes-dbt-layer`.`dae_sources`.`customers`)


  SELECT *
    FROM stg_customers;

