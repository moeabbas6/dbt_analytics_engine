select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`not_null_fct_orders_timeseries_sma_sales_sma_60`
    
      limit 1000
    ) dbt_internal_test