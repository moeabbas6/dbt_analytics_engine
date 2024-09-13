select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_expectations_source_expect_f537bd962af0a4eb264673c82dbed32d`
    
      limit 20
    ) dbt_internal_test