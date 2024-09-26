
  
    

    create or replace table `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_payment_methods`
        
  (
    country_id int64 not null,
    country string not null,
    order_id string not null primary key not enforced,
    nb_payments int64 not null,
    payment_methods string not null,
    order_date datetime not null,
    order_status string not null,
    total_gross_revenue float64 not null,
    total_payment_fees float64 not null,
    amazon_pay_payment_fees float64 not null,
    apple_pay_payment_fees float64 not null,
    bitcoin_payment_fees float64 not null,
    stripe_payment_fees float64 not null,
    amazon_pay_amount float64 not null,
    apple_pay_amount float64 not null,
    bitcoin_amount float64 not null,
    stripe_amount float64 not null
    
    )

      
    partition by range_bucket(
            country_id,
            generate_array(0, 100, 1)
        )
    cluster by order_date

    OPTIONS(
      expiration_timestamp=TIMESTAMP_ADD(CURRENT_TIMESTAMP(), INTERVAL 72 hour),
    
      description="""Fact table containing details of payment methods used in customer orders."""
    )
    as (
      
    select country_id, country, order_id, nb_payments, payment_methods, order_date, order_status, total_gross_revenue, total_payment_fees, amazon_pay_payment_fees, apple_pay_payment_fees, bitcoin_payment_fees, stripe_payment_fees, amazon_pay_amount, apple_pay_amount, bitcoin_amount, stripe_amount
    from (
        



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


  ,final AS (
  SELECT *
    FROM fct_payment_methods)


  SELECT *
    FROM final
    ) as model_subq
    );
  