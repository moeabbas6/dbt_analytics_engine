select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dim_products_assert_positive_total_payment_fee`
    
      limit 20
    ) dbt_internal_test