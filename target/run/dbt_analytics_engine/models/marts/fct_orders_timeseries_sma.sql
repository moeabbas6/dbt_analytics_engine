
  
    

    create or replace table `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders_timeseries_sma`
        
  (
    date date not null primary key not enforced,
    sales float64 not null,
    sales_sma_14 float64 not null,
    sales_sma_30 float64 not null,
    sales_sma_60 float64 not null,
    sales_sma_120 float64 not null,
    sales_sma_250 float64 not null,
    sales_stddev_14 float64,
    sales_stddev_30 float64,
    sales_stddev_60 float64,
    sales_stddev_120 float64,
    sales_stddev_250 float64,
    sales_sma_upper_14 float64,
    sales_sma_lower_14 float64,
    sales_sma_upper_30 float64,
    sales_sma_lower_30 float64,
    sales_sma_upper_60 float64,
    sales_sma_lower_60 float64,
    sales_sma_upper_120 float64,
    sales_sma_lower_120 float64,
    sales_sma_upper_250 float64,
    sales_sma_lower_250 float64
    
    )

      
    
    cluster by date

    OPTIONS(
      description="""Fact table capturing the daily sales time series data, including the total net revenue after tax (`sales`).  The table also includes various Simple Moving Averages (SMA) and Bollinger Bands calculated over different  periods (14, 30, 60, 120, and 250 days). This table is essential for analyzing sales trends, understanding  market volatility, and smoothing out fluctuations in daily sales data.\"\n"""
    )
    as (
      
    select date, sales, sales_sma_14, sales_sma_30, sales_sma_60, sales_sma_120, sales_sma_250, sales_stddev_14, sales_stddev_30, sales_stddev_60, sales_stddev_120, sales_stddev_250, sales_sma_upper_14, sales_sma_lower_14, sales_sma_upper_30, sales_sma_lower_30, sales_sma_upper_60, sales_sma_lower_60, sales_sma_upper_120, sales_sma_lower_120, sales_sma_upper_250, sales_sma_lower_250
    from (
        



WITH
  fct_orders_timeseries_sma AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`
      GROUP BY date)


  ,simple_moving_averages AS (
    SELECT date
          ,sales
          ,AVG(sales) OVER (ORDER BY date 
             ROWS BETWEEN 14 PRECEDING 
                  AND CURRENT ROW) AS sales_sma_14
          ,AVG(sales) OVER (ORDER BY date 
             ROWS BETWEEN 30 PRECEDING 
                  AND CURRENT ROW) AS sales_sma_30
          ,AVG(sales) OVER (ORDER BY date 
             ROWS BETWEEN 60 PRECEDING 
                  AND CURRENT ROW) AS sales_sma_60
          ,AVG(sales) OVER (ORDER BY date 
             ROWS BETWEEN 120 PRECEDING 
                  AND CURRENT ROW) AS sales_sma_120
          ,AVG(sales) OVER (ORDER BY date 
             ROWS BETWEEN 250 PRECEDING 
                  AND CURRENT ROW) AS sales_sma_250
      FROM fct_orders_timeseries_sma)


  ,standard_deviations AS (
    SELECT *
           ,STDDEV(sales) OVER (ORDER BY date 
              ROWS BETWEEN 14 PRECEDING 
                   AND CURRENT ROW) AS sales_stddev_14
           ,STDDEV(sales) OVER (ORDER BY date 
              ROWS BETWEEN 30 PRECEDING 
                   AND CURRENT ROW) AS sales_stddev_30
           ,STDDEV(sales) OVER (ORDER BY date 
              ROWS BETWEEN 60 PRECEDING 
                   AND CURRENT ROW) AS sales_stddev_60
           ,STDDEV(sales) OVER (ORDER BY date 
              ROWS BETWEEN 120 PRECEDING 
                   AND CURRENT ROW) AS sales_stddev_120
           ,STDDEV(sales) OVER (ORDER BY date 
              ROWS BETWEEN 250 PRECEDING 
                   AND CURRENT ROW) AS sales_stddev_250
      FROM simple_moving_averages)


  ,bollinger_bands AS (
    SELECT *
           ,sales_sma_14 
            + (2 * sales_stddev_14) AS sales_sma_upper_14
           ,sales_sma_14 
            - (2 * sales_stddev_14) AS sales_sma_lower_14
           ,sales_sma_30 
            + (2 * sales_stddev_30) AS sales_sma_upper_30
           ,sales_sma_30 
            - (2 * sales_stddev_30) AS sales_sma_lower_30
           ,sales_sma_60 
            + (2 * sales_stddev_60) AS sales_sma_upper_60
           ,sales_sma_60 
            - (2 * sales_stddev_60) AS sales_sma_lower_60
           ,sales_sma_120 
            + (2 * sales_stddev_120) AS sales_sma_upper_120
           ,sales_sma_120 
            - (2 * sales_stddev_120) AS sales_sma_lower_120
           ,sales_sma_250 
            + (2 * sales_stddev_250) AS sales_sma_upper_250
           ,sales_sma_250 
            - (2 * sales_stddev_250) AS sales_sma_lower_250
      FROM standard_deviations)

  SELECT *
    FROM bollinger_bands
    ) as model_subq
    );
  