select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_fct_o_e6d562c019ec93bf1cb7c5d2d43a4b1c`
    
      limit 100
    ) dbt_internal_test