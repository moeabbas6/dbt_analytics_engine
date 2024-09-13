

WITH
  first_names AS (
    SELECT 'James' AS first_name UNION ALL
    SELECT 'Mary' UNION ALL
    SELECT 'John' UNION ALL
    SELECT 'Patricia' UNION ALL
    SELECT 'Robert' UNION ALL
    SELECT 'Jennifer' UNION ALL
    SELECT 'Michael' UNION ALL
    SELECT 'Linda' UNION ALL
    SELECT 'William' UNION ALL
    SELECT 'Elizabeth')


  ,first_name_with_row_num AS (
    SELECT first_name
          ,ROW_NUMBER() OVER () AS row_num
      FROM first_names)


  ,random_numbers AS (
    SELECT CAST(FLOOR(RAND() * 10 + 1) AS INT64) AS rand_num
          ,ROW_NUMBER() OVER () AS rn
      FROM UNNEST(GENERATE_ARRAY(1, 275000)))


  ,customers AS (
    SELECT GENERATE_UUID() AS customer_id
          ,fn.first_name
          ,CONCAT(SUBSTR(UPPER(CHR(65 + CAST(FLOOR(RAND() * 26) AS INT64))), 1, 1), '.') AS last_name
      FROM random_numbers AS rn
      JOIN first_name_with_row_num AS fn ON rn.rand_num = fn.row_num)


  ,final AS (
    SELECT *
    FROM customers)


  SELECT *
    FROM final