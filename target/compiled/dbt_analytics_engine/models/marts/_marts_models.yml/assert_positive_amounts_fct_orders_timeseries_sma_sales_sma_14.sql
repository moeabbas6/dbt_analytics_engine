

SELECT sales_sma_14
  FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders_timeseries_sma`
  WHERE sales_sma_14 < 0

