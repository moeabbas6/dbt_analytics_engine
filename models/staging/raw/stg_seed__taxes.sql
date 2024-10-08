

WITH
  stg_taxes AS (
    SELECT tax_id AS country_id
          ,tax_country AS country
          ,tax_rate
      FROM {{ ref('seed_taxes') }})


  SELECT *
    FROM stg_taxes