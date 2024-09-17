
  
    

    create or replace table `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_payment_methods`
      
    partition by range_bucket(
            country_id,
            generate_array(0, 100, 1)
        )
    cluster by order_date

    OPTIONS(
      description="""Fact table containing details of payment methods used in customer orders."""
    )
    as (
      



WITH
  int_payments AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payments`)


  ,fct_payment_methods AS (
    SELECT country_id
           ,country
           ,order_id
           ,COUNT(order_payment_id) AS nb_payments
           ,IF(COUNT(DISTINCT payment_method) > 1, 'multiple', 'single') AS payment_methods
           ,MAX(created_at) AS order_date
           ,CASE 
            WHEN SUM(IF(payment_status = 'successful', 1, 0)) <> COUNT(order_payment_id) THEN 'failed'
            ELSE 'successful' END AS order_status
           ,SUM(gross_revenue) AS total_gross_revenue
           ,SUM(payment_fee) AS total_payment_fees
           ,SUM(CASE WHEN payment_method = 'amazon_pay' THEN payment_fee ELSE 0 END) AS amazon_pay_payment_fees
           ,SUM(CASE WHEN payment_method = 'apple_pay' THEN payment_fee ELSE 0 END) AS apple_pay_payment_fees
           ,SUM(CASE WHEN payment_method = 'bitcoin' THEN payment_fee ELSE 0 END) AS bitcoin_payment_fees
           ,SUM(CASE WHEN payment_method = 'stripe' THEN payment_fee ELSE 0 END) AS stripe_payment_fees
           ,SUM(CASE WHEN payment_method = 'amazon_pay' THEN gross_revenue ELSE 0 END) AS amazon_pay_amount
           ,SUM(CASE WHEN payment_method = 'apple_pay' THEN gross_revenue ELSE 0 END) AS apple_pay_amount
           ,SUM(CASE WHEN payment_method = 'bitcoin' THEN gross_revenue ELSE 0 END) AS bitcoin_amount
           ,SUM(CASE WHEN payment_method = 'stripe' THEN gross_revenue ELSE 0 END) AS stripe_amount
           FROM int_payments
      GROUP BY country_id
              ,country
              ,order_id)


  SELECT *
    FROM fct_payment_methods
    );
  