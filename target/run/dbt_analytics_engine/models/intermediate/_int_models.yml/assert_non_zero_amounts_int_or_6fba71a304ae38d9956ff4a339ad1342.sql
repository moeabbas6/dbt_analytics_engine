select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`assert_non_zero_amounts_int_or_6fba71a304ae38d9956ff4a339ad1342`
    
      limit 100
    ) dbt_internal_test