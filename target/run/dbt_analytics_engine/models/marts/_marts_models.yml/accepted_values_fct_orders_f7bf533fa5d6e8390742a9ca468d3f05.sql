select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`accepted_values_fct_orders_f7bf533fa5d6e8390742a9ca468d3f05`
    
      limit 100
    ) dbt_internal_test