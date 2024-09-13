select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_stg_s_7e7689bc643d07d2c7cba0db58f370f9`
    
      limit 100
    ) dbt_internal_test