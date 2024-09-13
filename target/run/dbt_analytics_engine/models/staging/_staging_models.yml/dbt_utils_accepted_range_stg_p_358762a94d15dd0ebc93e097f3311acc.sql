select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_stg_p_358762a94d15dd0ebc93e097f3311acc`
    
      limit 100
    ) dbt_internal_test