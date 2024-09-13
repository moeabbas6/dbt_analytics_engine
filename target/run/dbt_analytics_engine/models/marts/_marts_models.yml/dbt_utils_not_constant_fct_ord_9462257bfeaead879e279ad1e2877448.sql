select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_not_constant_fct_ord_9462257bfeaead879e279ad1e2877448`
    
      limit 20
    ) dbt_internal_test