select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`unexpected_order_status_int_order_lvl_joined`
    
      limit 100
    ) dbt_internal_test