select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`source_accepted_values_returns_89db19f4d3c7fdeade8ecc3fd9299ceb`
    
      limit 100
    ) dbt_internal_test