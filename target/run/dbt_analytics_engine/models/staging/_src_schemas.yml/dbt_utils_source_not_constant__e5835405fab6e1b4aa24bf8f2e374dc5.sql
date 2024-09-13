select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_source_not_constant__e5835405fab6e1b4aa24bf8f2e374dc5`
    
      limit 20
    ) dbt_internal_test