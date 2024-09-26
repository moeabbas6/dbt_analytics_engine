





WITH
  fct_orders_timeseries AS (
    SELECT
      DATE(order_date) AS date,
      country,
      SUM(net_revenue_after_tax) AS sales
    FROM `moes-dbt-layer`.`sales`.`fct_orders`
    GROUP BY date, country
  ),

  min_dates AS (
    SELECT
      country,
      MIN(date) AS min_date
    FROM fct_orders_timeseries
    GROUP BY country
  ),

  date_series AS (
    SELECT
      md.country,
      date
    FROM min_dates md
    CROSS JOIN UNNEST(
      GENERATE_DATE_ARRAY(
        md.min_date,
        DATE_ADD(CURRENT_DATE(), INTERVAL 14 DAY),
        INTERVAL 1 DAY
      )
    ) AS date
  ),

  sales_with_future_dates AS (
    SELECT
      ds.date,
      ds.country,
      f.sales
    FROM date_series ds
    LEFT JOIN fct_orders_timeseries f
      ON ds.date = f.date AND ds.country = f.country
  ),

  sales_with_indices AS (
    SELECT
      swfd.*,
      DATE_DIFF(swfd.date, md.min_date, DAY) AS date_index
    FROM sales_with_future_dates swfd
    JOIN min_dates md
      ON swfd.country = md.country
  ),

  sales_forecast AS (
    SELECT
      *,
      COALESCE(
        sales,
        LAST_VALUE(sales IGNORE NULLS) OVER (PARTITION BY country ORDER BY date)
      ) AS sales_forecasted
    FROM sales_with_indices
  ),

  linear_regression AS (
    SELECT
      country,
      SUM(CASE WHEN date <= CURRENT_DATE() THEN date_index * sales_forecasted ELSE 0 END) AS sum_xy,
      SUM(CASE WHEN date <= CURRENT_DATE() THEN date_index ELSE 0 END) AS sum_x,
      SUM(CASE WHEN date <= CURRENT_DATE() THEN sales_forecasted ELSE 0 END) AS sum_y,
      SUM(CASE WHEN date <= CURRENT_DATE() THEN date_index * date_index ELSE 0 END) AS sum_xx,
      COUNT(CASE WHEN date <= CURRENT_DATE() THEN 1 END) AS n
    FROM sales_forecast
    GROUP BY country
  ),

  coefficients AS (
    SELECT
      country,
      (n * sum_xy - sum_x * sum_y) / NULLIF(n * sum_xx - sum_x * sum_x, 0) AS slope,
      (sum_y - ((n * sum_xy - sum_x * sum_y) / NULLIF(n * sum_xx - sum_x * sum_x, 0)) * sum_x) / n AS intercept
    FROM linear_regression
  ),

  sales_forecast_with_trend AS (
    SELECT
      sf.*,
      CASE
        WHEN sf.date <= CURRENT_DATE() THEN sf.sales_forecasted
        WHEN c.slope IS NOT NULL THEN c.slope * sf.date_index + c.intercept
        ELSE sf.sales_forecasted  -- Fallback in case of NULL coefficients
      END AS sales_forecasted_trend
    FROM sales_forecast sf
    LEFT JOIN coefficients c
      ON sf.country = c.country
  ),

  weighted_moving_average AS (
    SELECT *,
      COALESCE(
        (0.4 * LAG(sales_forecasted_trend, 0) OVER (PARTITION BY country ORDER BY date)
             + 0.2 * LAG(sales_forecasted_trend, 1) OVER (PARTITION BY country ORDER BY date)
             + 0.15 * LAG(sales_forecasted_trend, 2) OVER (PARTITION BY country ORDER BY date)
             + 0.1 * LAG(sales_forecasted_trend, 3) OVER (PARTITION BY country ORDER BY date)
             + 0.075 * LAG(sales_forecasted_trend, 4) OVER (PARTITION BY country ORDER BY date)
             + 0.05 * LAG(sales_forecasted_trend, 5) OVER (PARTITION BY country ORDER BY date)
             + 0.025 * LAG(sales_forecasted_trend, 6) OVER (PARTITION BY country ORDER BY date)
            ), sales_forecasted_trend
      ) AS sales_wma_7
    FROM sales_forecast_with_trend
  ),

  simple_moving_averages AS (
    SELECT *,
      AVG(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW
      ) AS sales_sma_7,
      AVG(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
      ) AS sales_sma_14,
      AVG(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 30 PRECEDING AND CURRENT ROW
      ) AS sales_sma_30,
      AVG(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 60 PRECEDING AND CURRENT ROW
      ) AS sales_sma_60,
      AVG(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 120 PRECEDING AND CURRENT ROW
      ) AS sales_sma_120
    FROM weighted_moving_average
  ),

  standard_deviations AS (
    SELECT *,
      STDDEV(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 7 PRECEDING AND CURRENT ROW
      ) AS sales_stddev_7,
      STDDEV(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 14 PRECEDING AND CURRENT ROW
      ) AS sales_stddev_14,
      STDDEV(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 30 PRECEDING AND CURRENT ROW
      ) AS sales_stddev_30,
      STDDEV(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 60 PRECEDING AND CURRENT ROW
      ) AS sales_stddev_60,
      STDDEV(sales_forecasted_trend) OVER (
        PARTITION BY country ORDER BY date ROWS BETWEEN 120 PRECEDING AND CURRENT ROW
      ) AS sales_stddev_120
    FROM simple_moving_averages
  ),

  bollinger_bands AS (
    SELECT
      date,
      country,
      sales,
      sales_forecasted_trend AS sales_forecasted,
      sales_wma_7,
      sales_sma_7,
      sales_sma_7 + (2 * sales_stddev_7) AS sales_sma_upper_7,
      sales_sma_7 - (2 * sales_stddev_7) AS sales_sma_lower_7,
      sales_sma_14,
      sales_sma_14 + (2 * sales_stddev_14) AS sales_sma_upper_14,
      sales_sma_14 - (2 * sales_stddev_14) AS sales_sma_lower_14,
      sales_sma_30,
      sales_sma_30 + (2 * sales_stddev_30) AS sales_sma_upper_30,
      sales_sma_30 - (2 * sales_stddev_30) AS sales_sma_lower_30,
      sales_sma_60,
      sales_sma_60 + (2 * sales_stddev_60) AS sales_sma_upper_60,
      sales_sma_60 - (2 * sales_stddev_60) AS sales_sma_lower_60,
      sales_sma_120,
      sales_sma_120 + (2 * sales_stddev_120) AS sales_sma_upper_120,
      sales_sma_120 - (2 * sales_stddev_120) AS sales_sma_lower_120
    FROM standard_deviations
  )

SELECT *
FROM bollinger_bands