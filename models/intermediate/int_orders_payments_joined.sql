

WITH 
  int_orders_joined AS (
    SELECT *
      FROM {{ ref('int_orders_joined') }})


  ,int_payments_joined AS (
    SELECT order_id
          ,COUNT(payment_id) AS nb_payments
          ,MAX(payment_method) AS payment_method
          ,MAX(country_id) AS country_id
          ,MAX(country) AS country
          ,SUM(gross_revenue) AS gross_revenue
          ,MAX(tax_rate) AS tax_rate
          ,SUM(payment_fee) AS payment_fee
      FROM {{ ref('int_payments_joined') }}
      GROUP BY order_id)


  ,final AS (
    SELECT *
      FROM int_orders_joined
      JOIN int_payments_joined USING (order_id))


  SELECT *
    FROM final