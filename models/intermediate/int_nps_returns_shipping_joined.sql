

WITH
  stg_nps AS (
    SELECT *
      FROM {{ ref('stg_raw__nps') }})


  ,stg_returns AS (
    SELECT *
      FROM {{ ref('stg_raw__returns') }})


  ,stg_shipping AS (
    SELECT *
      FROM {{ ref('stg_raw__shipping') }})



  ,nps_returns_shipping AS (
    SELECT *
      FROM stg_shipping
      LEFT JOIN stg_returns USING (order_id)
      LEFT JOIN stg_nps USING (order_id))


  ,final AS (
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
      FROM nps_returns_shipping)


  SELECT *
    FROM final