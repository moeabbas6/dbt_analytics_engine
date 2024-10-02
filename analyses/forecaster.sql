WITH
  daily_sales AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM {{ ref('fct_orders') }}
      WHERE order_date >= DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH)
        AND order_date <= LAST_DAY(DATE_TRUNC(DATE_ADD(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH))
      GROUP BY date),


  avg_daily_sales AS (
    SELECT AVG(sales) as avg_daily_net_revenue
      FROM daily_sales
      WHERE date >= CURRENT_DATE - INTERVAL 1 MONTH),


  avg_weekday_sales AS (
    SELECT EXTRACT(DAYOFWEEK FROM date) AS weekday
          ,AVG(sales) as avg_weekday_net_revenue
      FROM daily_sales
      WHERE date >= CURRENT_DATE - INTERVAL 1 MONTH
      GROUP BY weekday),


  weekday_adjustment AS (
    SELECT weekday
          ,SAFE_DIVIDE(avg_weekday_net_revenue, avg_daily_net_revenue) AS weekday_effect
        FROM avg_weekday_sales
            ,avg_daily_sales),


  avg_recent_sales AS (
    SELECT AVG(sales) as avg_net_revenue
      FROM daily_sales
      WHERE date >= CURRENT_DATE - INTERVAL 14 DAY),


  sales_forecast AS (
    SELECT weekday
          ,avg_net_revenue * weekday_effect AS forecasted_sales
      FROM weekday_adjustment
          ,avg_recent_sales),


  future_dates AS (
    SELECT date
          ,EXTRACT(DAYOFWEEK FROM date) AS weekday
      FROM UNNEST(GENERATE_DATE_ARRAY(
                   DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH),
                   LAST_DAY(CURRENT_DATE(), MONTH),
                   INTERVAL 1 DAY)) AS date),


  forecast_with_dates AS (
    SELECT future_dates.date
          ,forecasted_sales
      FROM future_dates
      LEFT JOIN sales_forecast USING (weekday)),


  historical_sales AS (
    SELECT date
          ,sales
      FROM daily_sales),


  final AS (
    SELECT *
      FROM historical_sales
      FULL JOIN forecast_with_dates USING (date))

SELECT *
  FROM final