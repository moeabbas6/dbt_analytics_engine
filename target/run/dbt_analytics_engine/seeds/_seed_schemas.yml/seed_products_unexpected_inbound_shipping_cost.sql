select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`seed_products_unexpected_inbound_shipping_cost`
    
      limit 20
    ) dbt_internal_test