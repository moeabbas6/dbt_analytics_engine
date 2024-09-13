select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`assert_positive_amounts_dim_pr_18880855c727801deb84834d05da6c2a`
    
      limit 20
    ) dbt_internal_test