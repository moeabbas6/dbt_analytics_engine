select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_fct_o_cfca02a119b72f72db3e96877ef8af99`
    
      limit 100
    ) dbt_internal_test