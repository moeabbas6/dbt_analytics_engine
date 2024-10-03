{{ config(materialized='table') }}

WITH actuals AS (
  SELECT
    date,
    sales
  FROM
    {{ ref('fct_sales_timeseries') }}
),
forecasts AS (
  SELECT
    date,
    sales_arima_forecast
  FROM
    {{ ref('sales_forecast') }}
)
SELECT
  COALESCE(a.date, f.date) AS date,
  a.sales,
  f.sales_arima_forecast
FROM
  actuals a
FULL OUTER JOIN
  forecasts f USING (date)
ORDER BY
  date