{{ config(
    materialized = "incremental",
    unique_key = "date",
    on_schema_change = 'append_new_columns',
    cluster_by = 'date'
)}}

{% set periods = [7, 14, 30, 60, 120] %}
{% set weights = [0.4, 0.2, 0.15, 0.1, 0.075, 0.05, 0.025] %}
{% set forecast_horizon = 14 %}

WITH
  fct_orders_timeseries AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM {{ ref('fct_orders') }}
      WHERE order_date < CURRENT_DATE
      {%- if is_incremental() %}
        AND order_date >= (SELECT DATE_SUB(MAX(date), INTERVAL 3 DAY) 
                              FROM {{ this }}
                              WHERE sales IS NOT NULL)
      {%- endif %}
      GROUP BY date)


  ,date_series AS (
    SELECT date
      FROM UNNEST(
        GENERATE_DATE_ARRAY(
          (SELECT MIN(date) FROM fct_orders_timeseries),
          DATE_ADD(CURRENT_DATE(), INTERVAL {{ forecast_horizon }} DAY),
          INTERVAL 1 DAY)) AS date)

  
  ,sales_with_future_dates AS (
    SELECT date
          ,sales
      FROM date_series
      LEFT JOIN fct_orders_timeseries USING (date))


  ,sales_with_indices AS (
    SELECT *
          ,DATE_DIFF(date, (SELECT MIN(date) FROM fct_orders_timeseries), DAY) AS date_index
      FROM sales_with_future_dates)


  ,sales_forecast AS (
    SELECT date
          ,sales
          ,COALESCE(sales, LAST_VALUE(sales IGNORE NULLS) OVER (ORDER BY date)) AS sales_forecasted
          ,date_index
      FROM sales_with_indices)


  ,linear_regression AS (
    SELECT SUM(CASE WHEN date <= CURRENT_DATE() THEN date_index * sales_forecasted ELSE 0 END) AS sum_xy
          ,SUM(CASE WHEN date <= CURRENT_DATE() THEN date_index ELSE 0 END) AS sum_x
          ,SUM(CASE WHEN date <= CURRENT_DATE() THEN sales_forecasted ELSE 0 END) AS sum_y
          ,SUM(CASE WHEN date <= CURRENT_DATE() THEN date_index * date_index ELSE 0 END) AS sum_xx
          ,COUNT(CASE WHEN date <= CURRENT_DATE() THEN 1 END) AS n
      FROM sales_forecast)


  ,coefficients AS (
    SELECT (n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x * sum_x) AS slope
          ,(sum_y - ((n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x * sum_x)) * sum_x) / n AS intercept
      FROM linear_regression)

  
  ,sales_forecast_with_trend AS (
    SELECT sf.date
          ,sf.sales
          ,CASE
            WHEN sf.date <= CURRENT_DATE() THEN sf.sales_forecasted
            ELSE c.slope * sf.date_index + c.intercept END AS sales_forecasted_trend
      FROM sales_forecast sf
          ,coefficients c)


  ,weighted_moving_average AS (
    SELECT *
           ,COALESCE(
            ({% for lag_value in range(weights | length) -%}
                {{ weights[lag_value] }} * LAG(sales_forecasted_trend, {{ lag_value }}) OVER (ORDER BY date)
                {% if not loop.last %} + {% endif %}
              {%- endfor -%}), sales_forecasted_trend) AS sales_wma_7
      FROM sales_forecast_with_trend)


  ,simple_moving_averages AS (
    SELECT *
          {%- for period in periods %}
          ,AVG(sales_forecasted_trend) OVER (ORDER BY date ROWS BETWEEN {{ period }} PRECEDING AND CURRENT ROW) AS sales_sma_{{ period }}
          {%- endfor %}
      FROM weighted_moving_average)

  
  ,standard_deviations AS (
    SELECT *
          {%- for period in periods %}
          ,STDDEV(sales_forecasted_trend) OVER (ORDER BY date ROWS BETWEEN {{ period }} PRECEDING AND CURRENT ROW) AS sales_stddev_{{ period }}
          {%- endfor %}
      FROM simple_moving_averages)


  ,bollinger_bands AS (
    SELECT date
          ,sales
          ,sales_wma_7
          {%- for period in periods %}
          ,sales_sma_{{ period }}
          ,sales_sma_{{ period }} + (2 * sales_stddev_{{ period }}) AS sales_sma_upper_{{ period }}
          ,sales_sma_{{ period }} - (2 * sales_stddev_{{ period }}) AS sales_sma_lower_{{ period }}
          {%- endfor %}
      FROM standard_deviations)


  SELECT *
  FROM bollinger_bands