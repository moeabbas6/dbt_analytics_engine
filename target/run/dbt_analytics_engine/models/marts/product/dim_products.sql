
  
    

    create or replace table `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dim_products`
      
    partition by range_bucket(
            country_id,
            generate_array(0, 100, 1)
        )
    cluster by date

    OPTIONS(
      description="""This table contains dimensional data for products across different categories, regions, and timeframes.  It provides aggregated insights into sales, returns, shipping, and revenue performance, along with key  customer satisfaction and operational metrics. The table is used in dashboards for product performance  analysis and sales strategy optimization.\n"""
    )
    as (
      





WITH
  dim_products AS (
    SELECT DATE(order_date) AS date
          ,country_id
          ,country
          ,product_category
          ,product_name
          ,COUNT(order_id) AS nb_order_id
          ,COUNT(shipping_id) AS nb_shipping_id
          ,COUNT(return_id) AS nb_return_id
          ,ROUND(AVG(fulfillment_days), 2) AS avg_fulfillment_days
          ,ROUND(AVG(nps_score), 2) AS avg_nps_score
          ,ROUND(SUM(gross_revenue), 2) AS total_gross_revenue
          ,ROUND(SUM(tax_amount), 2) AS total_tax_amount
          ,ROUND(SUM(net_revenue_before_tax), 2) AS total_net_revenue_before_tax
          ,ROUND(SUM(net_revenue_after_tax), 2) AS total_net_revenue_after_tax
          ,ROUND(SUM(cogs), 2) AS total_cogs
          ,ROUND(SUM(returned_cogs), 2) AS total_returned_cogs
          ,ROUND(SUM(refund_amount), 2) AS total_refund_amount
          ,ROUND(SUM(payment_fee), 2) AS total_payment_fee
          ,ROUND(SUM(cm), 2) AS total_cm
          FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`
      GROUP BY date
              ,country_id
              ,country
              ,product_category
              ,product_name)

  SELECT *
    FROM dim_products
    );
  