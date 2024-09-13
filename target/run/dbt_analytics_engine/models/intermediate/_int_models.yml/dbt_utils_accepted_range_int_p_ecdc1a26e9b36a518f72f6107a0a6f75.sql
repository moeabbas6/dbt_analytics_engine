select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_int_p_ecdc1a26e9b36a518f72f6107a0a6f75`
    
      limit 100
    ) dbt_internal_test