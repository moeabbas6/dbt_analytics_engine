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
          ,COALESCE(sales_sma_{{ period }} + (2 * sales_stddev_{{ period }}), sales) AS sales_sma_upper_{{ period }}
          ,COALESCE(sales_sma_{{ period }} - (2 * sales_stddev_{{ period }}), sales) AS sales_sma_lower_{{ period }}
          {%- endfor %}
      FROM standard_deviations)


  ,final AS (
    SELECT *
      FROM bollinger_bands)


  SELECT *
    FROM final