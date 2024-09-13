select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`assert_positive_amounts_dim_pr_22d99b16c17685ec061444765a47e766`
    
      limit 20
    ) dbt_internal_test