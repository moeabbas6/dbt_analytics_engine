

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


  ,metrics AS (
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
          ,SAFE_MULTIPLY(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), SAFE_DIVIDE(tax_rate, 100)) AS tax_amount
          ,SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)) AS net_revenue_before_tax
          ,SAFE_DIVIDE(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), (1 + SAFE_DIVIDE(tax_rate, 100))) AS net_revenue_after_tax
          ,DATE_DIFF(shipping_date, order_date, DAY) AS fulfillment_days
          ,SAFE_ADD(inbound_shipping_cost, product_cost) AS cogs
          ,IF(is_returned IS TRUE, SAFE_ADD(inbound_shipping_cost, product_cost), 0) AS returned_cogs
          ,IF(is_returned IS TRUE, SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), 0) AS refund_amount
          ,IF(customer_order_nb > 1, 'Returning', 'New') AS customer_type
      FROM int_order_lvl_joined
      JOIN int_payments_lvl_joined USING (order_id))


    ,contribution_margin AS (
      SELECT *
            ,COALESCE(net_revenue_after_tax, 0)
              - COALESCE(cogs, 0)
                - COALESCE(refund_amount, 0)
                  - COALESCE(payment_fee, 0)
                    + COALESCE(returned_cogs, 0) AS cm
        FROM metrics)


  SELECT *
    FROM contribution_margin