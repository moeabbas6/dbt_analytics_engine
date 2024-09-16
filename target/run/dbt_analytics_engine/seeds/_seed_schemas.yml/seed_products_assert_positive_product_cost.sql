select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`seed_products_assert_positive_product_cost`
    
      limit 20
    ) dbt_internal_test