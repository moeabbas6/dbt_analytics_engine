
  
    

    create or replace table `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`
        
  (
    country_id int64 not null,
    country string not null,
    order_id string not null primary key not enforced,
    order_status string not null,
    customer_id string not null,
    nb_payments int64 not null,
    first_name string not null,
    last_name string not null,
    is_shipped boolean,
    shipping_id string,
    shipping_amount float64,
    payment_method string not null,
    gross_revenue float64 not null,
    tax_rate float64 not null,
    tax_amount float64 not null,
    net_revenue_before_tax float64 not null,
    net_revenue_after_tax float64 not null,
    order_date datetime not null,
    shipping_date datetime,
    is_returned boolean,
    return_id string,
    return_date datetime,
    return_reason string,
    fulfillment_days int64,
    is_nps boolean,
    nps_score int64,
    nps_date datetime,
    product_category_id int64 not null,
    product_category string not null,
    product_id int64 not null,
    product_name string not null,
    cogs float64 not null,
    returned_cogs float64 not null,
    refund_amount float64 not null,
    payment_fee float64 not null,
    cm float64 not null,
    customer_order_nb int64 not null,
    customer_type string not null
    
    )

      
    partition by range_bucket(
            country_id,
            generate_array(0, 100, 1)
        )
    cluster by order_date

    OPTIONS(
      description="""Fact table capturing detailed information about customer orders, including order details, payment methods,  shipping, returns, and customer feedback. This table provides a comprehensive view of each order's lifecycle,  enabling in-depth analysis of sales performance, customer behavior, and product profitability.\n"""
    )
    as (
      
    select country_id, country, order_id, order_status, customer_id, nb_payments, first_name, last_name, is_shipped, shipping_id, shipping_amount, payment_method, gross_revenue, tax_rate, tax_amount, net_revenue_before_tax, net_revenue_after_tax, order_date, shipping_date, is_returned, return_id, return_date, return_reason, fulfillment_days, is_nps, nps_score, nps_date, product_category_id, product_category, product_id, product_name, cogs, returned_cogs, refund_amount, payment_fee, cm, customer_order_nb, customer_type
    from (
        


WITH
  int_orders AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_orders`)


  ,int_payments AS (
    SELECT order_id
          ,COUNT(payment_id) AS nb_payments
          ,MAX(payment_method) AS payment_method
          ,MAX(country_id) AS country_id
          ,MAX(country) AS country
          ,SUM(gross_revenue) AS gross_revenue
          ,MAX(tax_rate) AS tax_rate
          ,SUM(payment_fee) AS payment_fee
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payments`
      GROUP BY order_id)


  ,joins AS (
      SELECT country_id
            ,country
            ,order_id
            ,order_status
            ,customer_id
            ,nb_payments
            ,first_name
            ,last_name
            ,shipping_id
            ,is_shipped
            ,shipping_amount
            ,payment_method
            ,gross_revenue
            ,tax_rate
            ,SAFE_MULTIPLY(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), SAFE_DIVIDE(tax_rate, 100)) AS tax_amount
            ,SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)) AS net_revenue_before_tax
            ,SAFE_DIVIDE(SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), (1 + SAFE_DIVIDE(tax_rate, 100))) AS net_revenue_after_tax
            ,order_date
            ,shipping_date
            ,DATE_DIFF(shipping_date, order_date, DAY) AS fulfillment_days
            ,IF(is_nps IS NULL, FALSE, TRUE) AS is_nps
            ,nps_score
            ,nps_date
            ,product_category_id
            ,product_category
            ,product_id
            ,product_name
            ,SAFE_ADD(inbound_shipping_cost, product_cost) AS cogs
            ,return_id
            ,IF(is_returned IS NULL, FALSE, TRUE) AS is_returned
            ,return_date
            ,return_reason
            ,IF(is_returned IS TRUE, SAFE_ADD(inbound_shipping_cost, product_cost), 0) AS returned_cogs
            ,IF(is_returned IS TRUE, SAFE_SUBTRACT(gross_revenue, COALESCE(shipping_amount, 0)), 0) AS refund_amount
            ,payment_fee
        FROM int_orders
        LEFT JOIN int_payments USING (order_id))


    ,contribution_margin AS (
      SELECT *
            ,COALESCE(net_revenue_after_tax, 0)
              - COALESCE(cogs, 0)
                - COALESCE(refund_amount, 0)
                  - COALESCE(payment_fee, 0)
                    + COALESCE(returned_cogs, 0) AS cm
        FROM joins)


    ,customers AS (
      SELECT customer_id
            ,order_id
            ,order_date AS customer_order_date
            ,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS customer_order_nb
        FROM contribution_margin
        GROUP BY ALL)


    ,final AS (
      SELECT * EXCEPT(customer_order_date)
            ,IF(customer_order_nb > 1, 'Returning', 'New') AS customer_type
        FROM contribution_margin
        LEFT JOIN customers USING (customer_id, order_id))


  SELECT *
    FROM final
    ) as model_subq
    );
  