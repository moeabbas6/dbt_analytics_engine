select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_fct_p_38649d48f1f04b03310e44e5053ecdbb`
    
      limit 100
    ) dbt_internal_test