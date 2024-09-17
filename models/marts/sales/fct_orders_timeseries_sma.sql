{{ config(
    cluster_by = 'date'
)}}

{% set periods = [14, 30, 60, 120, 250] %}

WITH
  fct_orders_timeseries_sma AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM {{ ref('fct_orders') }}
      GROUP BY date)


  ,simple_moving_averages AS (
    SELECT date
          ,sales
          {%- for period in periods %}
          ,AVG(sales) OVER (ORDER BY date ROWS BETWEEN {{ period }} PRECEDING AND CURRENT ROW) AS sales_sma_{{ period }}
          {%- endfor %}
      FROM fct_orders_timeseries_sma)


  ,standard_deviations AS (
    SELECT *
           {%- for period in periods %}
           ,STDDEV(sales) OVER (ORDER BY date ROWS BETWEEN {{ period }} PRECEDING AND CURRENT ROW) AS sales_stddev_{{ period }}
           {%- endfor %}
      FROM simple_moving_averages)


  ,bollinger_bands AS (
    SELECT *
           {%- for period in periods %}
           ,sales_sma_{{ period }} + (2 * sales_stddev_{{ period }}) AS sales_sma_upper_{{ period }}
           ,sales_sma_{{ period }} - (2 * sales_stddev_{{ period }}) AS sales_sma_lower_{{ period }}
           {%- endfor %}
      FROM standard_deviations)


  SELECT *
    FROM bollinger_bands

# Adding comment for slim ci test (schema)