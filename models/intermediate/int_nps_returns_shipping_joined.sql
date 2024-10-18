

WITH
  stg_raw__nps AS (
    SELECT *
      FROM {{ ref('stg_raw__nps') }})


  ,stg_raw__returns AS (
    SELECT *
      FROM {{ ref('stg_raw__returns') }})


  ,stg_raw__shipping AS (
    SELECT *
      FROM {{ ref('stg_raw__shipping') }})


  ,int_nps_returns_shipping_joined AS (
    SELECT order_id
          ,shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
          ,return_id
          ,is_returned
          ,return_date
          ,return_reason
          ,is_nps
          ,nps_score
          ,nps_date
      FROM stg_raw__shipping
      FULL JOIN stg_raw__returns USING (order_id)
      FULL JOIN stg_raw__nps USING (order_id))


  SELECT *
    FROM int_nps_returns_shipping_joined