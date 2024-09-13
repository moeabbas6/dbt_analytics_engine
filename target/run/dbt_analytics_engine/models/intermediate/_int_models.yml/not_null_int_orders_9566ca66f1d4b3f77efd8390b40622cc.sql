select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`not_null_int_orders_9566ca66f1d4b3f77efd8390b40622cc`
    
      limit 20
    ) dbt_internal_test