select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_source_accepted_rang_f7649a2756336d0952772bb5f8f2bc91`
    
      limit 100
    ) dbt_internal_test