select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`seed_payment_fees_unexpected_payment_method`
    
      limit 20
    ) dbt_internal_test