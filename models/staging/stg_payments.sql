

WITH
  stg_payments AS (
    SELECT order_id
          ,payment_id
          ,{{ dbt_utils.generate_surrogate_key(['order_id', 'payment_id']) }} AS order_payment_id
          ,payment_method
          ,payment_amount AS gross_revenue
          ,payment_country_id AS country_id
          ,payment_status
          ,created_at
      FROM {{ source("raw", "payments")}}
      WHERE created_at <= CURRENT_DATETIME('America/Toronto'))


  SELECT *
    FROM stg_payments