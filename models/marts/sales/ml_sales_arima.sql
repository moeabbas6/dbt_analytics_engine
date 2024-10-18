{{ config(
    materialized='model',
    ml_config = {
        'model_type': 'ARIMA_PLUS',
        'time_series_timestamp_col' : 'date',
        'time_series_data_col' : 'sales',
        'horizon' : 30
        }
)}}


WITH
  fct_sales_timeseries AS (
    SELECT date
          ,sales
      FROM {{ ref('fct_sales_timeseries') }})


  SELECT *
    FROM fct_sales_timeseries