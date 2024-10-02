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
  daily_sales AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM {{ ref('fct_orders') }}
      WHERE order_date < CURRENT_DATE
      {%- if is_incremental() %}
        AND order_date >= (SELECT DATE_SUB(MAX(date), INTERVAL 3 DAY) 
                              FROM {{ this }}
                              WHERE date < CURRENT_DATE)
      {%- endif %}
      GROUP BY date)


  ,weighted_moving_average AS (
    SELECT *
           ,COALESCE(
            ({% for lag_value in range(weights | length) -%}
                {{ weights[lag_value] }} * LAG(sales, {{ lag_value }}) OVER (ORDER BY date)
                {% if not loop.last %} + {% endif %}
              {%- endfor -%}), sales) AS sales_wma_7
      FROM daily_sales)


  ,simple_moving_averages AS (
    SELECT *
          {%- for period in periods %}
          ,AVG(sales) OVER (ORDER BY date ROWS BETWEEN {{ period }} PRECEDING AND CURRENT ROW) AS sales_sma_{{ period }}
          {%- endfor %}
      FROM weighted_moving_average)

  
  ,standard_deviations AS (
    SELECT *
          {%- for period in periods %}
          ,STDDEV(sales) OVER (ORDER BY date ROWS BETWEEN {{ period }} PRECEDING AND CURRENT ROW) AS sales_stddev_{{ period }}
          {%- endfor %}
      FROM simple_moving_averages)


  ,bollinger_bands AS (
    SELECT date
          ,IF(date < CURRENT_DATE AND sales IS NULL, 0, sales) AS sales
          ,sales_wma_7
          {%- for period in periods %}
          ,sales_sma_{{ period }}
          ,sales_sma_{{ period }} + (2 * sales_stddev_{{ period }}) AS sales_sma_upper_{{ period }}
          ,sales_sma_{{ period }} - (2 * sales_stddev_{{ period }}) AS sales_sma_lower_{{ period }}
          {%- endfor %}
      FROM standard_deviations)


## Forecaster
  ,avg_daily_sales AS (
    SELECT AVG(sales) as avg_daily_net_revenue
      FROM daily_sales
      WHERE date >= CURRENT_DATE - INTERVAL 1 MONTH)


  ,avg_weekday_sales AS (
    SELECT EXTRACT(DAYOFWEEK FROM date) AS weekday
          ,AVG(sales) as avg_weekday_net_revenue
      FROM daily_sales
      WHERE date >= CURRENT_DATE - INTERVAL 1 MONTH
      GROUP BY weekday)


  ,weekday_adjustment AS (
    SELECT weekday
          ,SAFE_DIVIDE(avg_weekday_net_revenue, avg_daily_net_revenue) AS weekday_effect
        FROM avg_weekday_sales
            ,avg_daily_sales)


  ,avg_recent_sales AS (
    SELECT AVG(sales) as avg_net_revenue
      FROM daily_sales
      WHERE date >= CURRENT_DATE - INTERVAL 15 DAY)


  ,sales_forecast AS (
    SELECT weekday
          ,avg_net_revenue * weekday_effect AS forecasted_sales
      FROM weekday_adjustment
          ,avg_recent_sales)

/*
  ,future_dates AS (
    SELECT date
          ,EXTRACT(DAYOFWEEK FROM date) AS weekday
      FROM UNNEST(GENERATE_DATE_ARRAY(
                   DATE_TRUNC(DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH), MONTH),
                   LAST_DAY(CURRENT_DATE(), MONTH),
                   INTERVAL 1 DAY)) AS date) */

  ,future_dates AS (
    SELECT date
          ,EXTRACT(DAYOFWEEK FROM date) AS weekday
      FROM UNNEST(GENERATE_DATE_ARRAY(
                   CURRENT_DATE,
                   DATE_ADD(CURRENT_DATE, INTERVAL 15 DAY),
                   INTERVAL 1 DAY)) AS date) 
                   

  ,forecast_with_dates AS (
    SELECT future_dates.date
          ,forecasted_sales
      FROM future_dates
      LEFT JOIN sales_forecast USING (weekday))


  ,final AS (
    SELECT *
      FROM bollinger_bands
      FULL JOIN forecast_with_dates USING (date))


  SELECT *
    FROM final