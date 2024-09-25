{{ config(
    cluster_by = 'date'
)}}

{% set periods = [7, 14, 30, 60, 120] %}
{% set weights = [0.4, 0.2, 0.15, 0.1, 0.075, 0.05, 0.025] %}


WITH
  fct_orders_timeseries AS (
    SELECT DATE(order_date) AS date
          ,SUM(net_revenue_after_tax) AS sales
      FROM {{ ref('fct_orders') }}
      GROUP BY date)


  ,weighted_moving_average AS (
    SELECT *
          ,COALESCE(({% for lag_value in range(weights | length) -%}
              {{ weights[lag_value] }} * LAG(sales, {{ lag_value }}) OVER (ORDER BY date)
              {% if not loop.last %} + {% endif -%}
            {%- endfor -%}), sales) AS sales_wma_7
      FROM fct_orders_timeseries)


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
    SELECT * EXCEPT (
              {%- for period in periods -%}
              sales_stddev_{{ period }}{%- if not loop.last %}, {% endif %}
              {%- endfor %})
           {%- for period in periods %}
           ,sales_sma_{{ period }} + (2 * sales_stddev_{{ period }}) AS sales_sma_upper_{{ period }}
           ,sales_sma_{{ period }} - (2 * sales_stddev_{{ period }}) AS sales_sma_lower_{{ period }}
           {%- endfor %}
      FROM standard_deviations)


  SELECT *
    FROM bollinger_bands