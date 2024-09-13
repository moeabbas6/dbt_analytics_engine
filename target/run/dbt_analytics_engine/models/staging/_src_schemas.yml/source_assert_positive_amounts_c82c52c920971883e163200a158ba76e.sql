select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`source_assert_positive_amounts_c82c52c920971883e163200a158ba76e`
    
      limit 20
    ) dbt_internal_test