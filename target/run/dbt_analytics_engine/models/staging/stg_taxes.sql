

  create or replace view `moes-dbt-layer`.`staging`.`stg_taxes`
  OPTIONS(
      description=""""""
    )
  as WITH
  stg_taxes AS (
    SELECT tax_id AS country_id
          ,tax_country AS country
          ,tax_rate
      FROM `moes-dbt-layer`.`seeds`.`seed_taxes`)


  SELECT *
    FROM stg_taxes;

