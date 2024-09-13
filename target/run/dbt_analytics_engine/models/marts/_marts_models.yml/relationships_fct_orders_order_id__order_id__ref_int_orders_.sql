select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`relationships_fct_orders_order_id__order_id__ref_int_orders_`
    
      limit 20
    ) dbt_internal_test