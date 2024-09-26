





WITH
  fct_orders_timeseries_sma AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM `moes-dbt-layer`.`sales`.`fct_orders`
      GROUP BY date)


  ,weighted_moving_average AS (
    SELECT *
          ,COALESCE((0.4 * LAG(sales, 0) OVER (ORDER BY date)
               + 0.2 * LAG(sales, 1) OVER (ORDER BY date)
               + 0.15 * LAG(sales, 2) OVER (ORDER BY date)
               + 0.1 * LAG(sales, 3) OVER (ORDER BY date)
               + 0.075 * LAG(sales, 4) OVER (ORDER BY date)
               + 0.05 * LAG(sales, 5) OVER (ORDER BY date)
               + 0.025 * LAG(sales, 6) OVER (ORDER BY date)
              ), sales) AS sales_wma_7
      FROM fct_orders_timeseries_sma)


  ,simple_moving_averages AS (
    SELECT *
          ,AVG(sales) OVER (ORDER BY date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) AS sales_sma_7
          ,AVG(sales) OVER (ORDER BY date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW) AS sales_sma_14
          ,AVG(sales) OVER (ORDER BY date ROWS BETWEEN 30 PRECEDING AND CURRENT ROW) AS sales_sma_30
          ,AVG(sales) OVER (ORDER BY date ROWS BETWEEN 60 PRECEDING AND CURRENT ROW) AS sales_sma_60
          ,AVG(sales) OVER (ORDER BY date ROWS BETWEEN 120 PRECEDING AND CURRENT ROW) AS sales_sma_120
      FROM weighted_moving_average)


  ,standard_deviations AS (
    SELECT *
           ,STDDEV(sales) OVER (ORDER BY date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW) AS sales_stddev_7
           ,STDDEV(sales) OVER (ORDER BY date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW) AS sales_stddev_14
           ,STDDEV(sales) OVER (ORDER BY date ROWS BETWEEN 30 PRECEDING AND CURRENT ROW) AS sales_stddev_30
           ,STDDEV(sales) OVER (ORDER BY date ROWS BETWEEN 60 PRECEDING AND CURRENT ROW) AS sales_stddev_60
           ,STDDEV(sales) OVER (ORDER BY date ROWS BETWEEN 120 PRECEDING AND CURRENT ROW) AS sales_stddev_120
      FROM simple_moving_averages)


  ,bollinger_bands AS (
    SELECT * EXCEPT (sales_stddev_7, sales_stddev_14, sales_stddev_30, sales_stddev_60, sales_stddev_120)
           ,sales_sma_7 + (2 * sales_stddev_7) AS sales_sma_upper_7
           ,sales_sma_7 - (2 * sales_stddev_7) AS sales_sma_lower_7
           ,sales_sma_14 + (2 * sales_stddev_14) AS sales_sma_upper_14
           ,sales_sma_14 - (2 * sales_stddev_14) AS sales_sma_lower_14
           ,sales_sma_30 + (2 * sales_stddev_30) AS sales_sma_upper_30
           ,sales_sma_30 - (2 * sales_stddev_30) AS sales_sma_lower_30
           ,sales_sma_60 + (2 * sales_stddev_60) AS sales_sma_upper_60
           ,sales_sma_60 - (2 * sales_stddev_60) AS sales_sma_lower_60
           ,sales_sma_120 + (2 * sales_stddev_120) AS sales_sma_upper_120
           ,sales_sma_120 - (2 * sales_stddev_120) AS sales_sma_lower_120
      FROM standard_deviations)


  SELECT *
    FROM bollinger_bands