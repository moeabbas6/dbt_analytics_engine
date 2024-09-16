select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`unique_seed_payment_fees_payment_method_id`
    
      limit 20
    ) dbt_internal_test