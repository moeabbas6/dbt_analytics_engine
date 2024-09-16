select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`not_null_seed_products_inbound_shipping_cost`
    
      limit 20
    ) dbt_internal_test