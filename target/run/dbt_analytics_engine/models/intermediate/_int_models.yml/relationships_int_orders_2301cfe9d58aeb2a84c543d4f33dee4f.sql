select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`relationships_int_orders_2301cfe9d58aeb2a84c543d4f33dee4f`
    
      limit 20
    ) dbt_internal_test