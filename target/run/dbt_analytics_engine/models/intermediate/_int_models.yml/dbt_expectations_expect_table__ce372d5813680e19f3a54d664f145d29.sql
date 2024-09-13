select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_expectations_expect_table__ce372d5813680e19f3a54d664f145d29`
    
      limit 20
    ) dbt_internal_test