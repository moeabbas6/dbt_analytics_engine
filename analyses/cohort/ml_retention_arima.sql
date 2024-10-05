{{ config(
    materialized='model',
    ml_config = {
        'model_type': 'ARIMA_PLUS',
        'time_series_timestamp_col' : 'date',
        'time_series_data_col' : 'avg_retention_rate',
        'decompose_time_series' : true
        }
)}}

  SELECT date
        ,avg_retention_rate
    FROM  {{ ref('fct_overall_retention_timeseries') }}
  ORDER BY date