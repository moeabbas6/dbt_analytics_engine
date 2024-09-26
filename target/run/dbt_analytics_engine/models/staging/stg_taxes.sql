

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_taxes`
  OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 72 hour),
    
      description=""""""
    )
  as WITH
  stg_taxes AS (
    SELECT tax_id AS country_id
          ,tax_country AS country
          ,tax_rate
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`seed_taxes`)


  SELECT *
    FROM stg_taxes;

