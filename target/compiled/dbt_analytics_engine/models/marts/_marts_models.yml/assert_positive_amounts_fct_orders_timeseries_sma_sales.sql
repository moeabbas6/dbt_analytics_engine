

SELECT sales
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders_timeseries_sma`
  WHERE sales < 0

