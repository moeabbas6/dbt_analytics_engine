select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_source_not_constant__d866ccd47a6b8ce95df3b451ad1b3bb8`
    
      limit 20
    ) dbt_internal_test