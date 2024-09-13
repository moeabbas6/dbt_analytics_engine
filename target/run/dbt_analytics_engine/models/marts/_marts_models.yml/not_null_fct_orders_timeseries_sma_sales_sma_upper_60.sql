select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >3 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`not_null_fct_orders_timeseries_sma_sales_sma_upper_60`
    
      limit 20
    ) dbt_internal_test