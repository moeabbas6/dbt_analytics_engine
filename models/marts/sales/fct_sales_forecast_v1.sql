{{ config(
    on_schema_change = 'append_new_columns',
    cluster_by = 'date'
)}}

WITH actuals AS (
  SELECT *
    FROM {{ ref('fct_sales_timeseries') }})


  ,forecasts AS (
    SELECT DATE(forecast_timestamp) AS date
          ,forecast_value AS sales_forecast
      FROM ML.FORECAST(MODEL {{ ref('ml_sales_arima') }}, STRUCT(30 AS horizon)))


  ,final AS (
    SELECT *
      FROM actuals
      FULL JOIN forecasts USING (date))


  SELECT *
    FROM final