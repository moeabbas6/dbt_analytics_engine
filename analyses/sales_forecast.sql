{{ config(materialized='table') }}

SELECT DATE(forecast_timestamp) AS date
      ,forecast_value AS sales_arima_forecast
  FROM ML.FORECAST(MODEL {{ ref('sales_arima') }}, STRUCT(30 AS horizon))
  ORDER BY date