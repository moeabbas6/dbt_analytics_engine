select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`dbt_utils_source_not_constant_raw_customers_last_name`
    
      limit 100
    ) dbt_internal_test