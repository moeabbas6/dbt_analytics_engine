select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`relationships_int_order_lvl_jo_5099704dad90325cc520be3eca054659`
    
      limit 100
    ) dbt_internal_test