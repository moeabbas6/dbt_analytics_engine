

WITH
  fct_sales_forecast AS (
    SELECT DATE(forecast_timestamp) AS date
          ,forecast_value AS sales_forecast
      FROM ML.FORECAST(MODEL {{ ref('ml_sales_arima') }}, STRUCT(30 AS horizon)))

  SELECT *
    FROM fct_sales_forecast