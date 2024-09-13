

SELECT sales_sma_250
  FROM `moes-dbt-layer`.`dbt_analytics_engine_prod`.`fct_orders_timeseries_sma`
  WHERE sales_sma_250 = 0

