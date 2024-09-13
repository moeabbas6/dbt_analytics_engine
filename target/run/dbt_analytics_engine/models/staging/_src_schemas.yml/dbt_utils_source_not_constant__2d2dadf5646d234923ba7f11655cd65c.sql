select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_source_not_constant__2d2dadf5646d234923ba7f11655cd65c`
    
      limit 20
    ) dbt_internal_test