select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_sequential_values_fc_f7a87e0fee2c7474c6f8c3b43c5ceb83`
    
      limit 20
    ) dbt_internal_test