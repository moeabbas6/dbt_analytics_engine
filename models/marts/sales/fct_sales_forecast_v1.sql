{{ config(
    on_schema_change = 'append_new_columns',
    cluster_by = 'date'
)}}


WITH 
  fct_sales_timeseries AS (
    SELECT *
      FROM {{ ref('fct_sales_timeseries') }})


  ,ml_sales_arima AS (
    SELECT DATE(forecast_timestamp) AS date
          ,forecast_value AS sales_forecast
      FROM ML.FORECAST(MODEL {{ ref('ml_sales_arima') }}, STRUCT(30 AS horizon)))


  ,fct_sales_forecast AS (
    SELECT *
      FROM fct_sales_timeseries
      FULL JOIN ml_sales_arima USING (date))


  SELECT *
    FROM fct_sales_forecast