

WITH 
  int_order_lvl_joined AS (
    SELECT *
      FROM {{ ref('int_order_lvl_joined') }})


  ,int_payments_lvl_joined AS (
    SELECT order_id
          ,COUNT(payment_id) AS nb_payments
          ,MAX(payment_method) AS payment_method
          ,MAX(country_id) AS country_id
          ,MAX(country) AS country
          ,SUM(gross_revenue) AS gross_revenue
          ,MAX(tax_rate) AS tax_rate
          ,SUM(payment_fee) AS payment_fee
      FROM {{ ref('int_payments_lvl_joined') }}
      GROUP BY order_id)


  ,final AS (
    SELECT country_id
          ,country
          ,order_id
          ,customer_id
          ,first_order_date
          ,customer_order_nb
          ,order_status
          ,order_date
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
          ,product_category_id
          ,product_category
          ,product_id
          ,product_name
          ,inbound_shipping_cost
          ,product_cost
          ,nb_payments
          ,payment_method
          ,gross_revenue
          ,tax_rate
          ,payment_fee
      FROM int_order_lvl_joined
      JOIN int_payments_lvl_joined USING (order_id))


  SELECT *
    FROM final