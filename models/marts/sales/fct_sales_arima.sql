{{ config(
    materialized='model',
    ml_config = {
        'model_type': 'ARIMA_PLUS',
        'time_series_timestamp_col' : 'date',
        'time_series_data_col' : 'sales',
        'horizon' : 30
        }
)}}

  SELECT date
        ,sales
    FROM {{ ref('fct_sales_timeseries') }}