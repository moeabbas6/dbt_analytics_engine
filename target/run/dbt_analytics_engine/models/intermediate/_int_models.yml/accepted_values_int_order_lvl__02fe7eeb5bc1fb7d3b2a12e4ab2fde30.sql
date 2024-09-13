select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`accepted_values_int_order_lvl__02fe7eeb5bc1fb7d3b2a12e4ab2fde30`
    
      limit 100
    ) dbt_internal_test