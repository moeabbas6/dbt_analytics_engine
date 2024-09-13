select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`relationships_fct_orders_3acc741ac9b5a6075a519555294a47c2`
    
      limit 100
    ) dbt_internal_test