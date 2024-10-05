

WITH
  forecasts AS (
    SELECT DATE(forecast_timestamp) AS date
          ,forecast_value AS predicted_retention_rate
          ,prediction_interval_lower_bound
          ,prediction_interval_upper_bound
    FROM ML.FORECAST(MODEL {{ ref('ml_retention_arima') }}, STRUCT(6 AS horizon))
    ORDER BY date)

  SELECT *
    FROM forecasts