

WITH
  seed_payment_fees AS (
    SELECT payment_method_id
          ,payment_method
          ,percentage_fee
          ,fixed_fee
      FROM {{ ref('seed_payment_fees') }})


  SELECT *
    FROM seed_payment_fees