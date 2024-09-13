select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_int_o_e67e85dec27c2dea6b8fd017a0e91b0d`
    
      limit 100
    ) dbt_internal_test