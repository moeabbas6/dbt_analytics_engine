

WITH
  stg_raw__payments AS (
    SELECT *
      FROM {{ ref('stg_raw__payments') }})


  ,stg_seed__taxes AS (
    SELECT * 
      FROM {{ ref('stg_seed__taxes') }})


  ,stg_seed__payment_fees AS (
    SELECT * 
      FROM {{ ref('stg_seed__payment_fees') }})


  ,int_payments_lvl_joined AS (
    SELECT order_id
          ,payment_id
          ,order_payment_id
          ,payment_method
          ,payment_status
          ,country_id
          ,country
          ,created_at
          ,gross_revenue
          ,tax_rate
          ,percentage_fee
          ,fixed_fee
          ,ROUND((gross_revenue * (percentage_fee / 100)) + fixed_fee, 2) AS payment_fee
      FROM stg_raw__payments
      LEFT JOIN stg_seed__taxes USING (country_id)
      LEFT JOIN stg_seed__payment_fees USING (payment_method))


  SELECT *
    FROM int_payments_lvl_joined