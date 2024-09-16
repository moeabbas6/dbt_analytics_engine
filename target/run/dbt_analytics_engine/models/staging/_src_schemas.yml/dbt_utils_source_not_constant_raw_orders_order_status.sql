select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_source_not_constant_raw_orders_order_status`
    
      limit 20
    ) dbt_internal_test