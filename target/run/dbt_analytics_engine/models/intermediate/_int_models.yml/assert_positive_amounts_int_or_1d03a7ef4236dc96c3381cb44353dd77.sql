select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`assert_positive_amounts_int_or_1d03a7ef4236dc96c3381cb44353dd77`
    
      limit 100
    ) dbt_internal_test