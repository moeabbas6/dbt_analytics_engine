select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_fct_o_c81286d2d0b7c3d929c4bddd36977097`
    
      limit 100
    ) dbt_internal_test