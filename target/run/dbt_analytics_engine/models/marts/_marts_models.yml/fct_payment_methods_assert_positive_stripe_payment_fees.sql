select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`fct_payment_methods_assert_positive_stripe_payment_fees`
    
      limit 20
    ) dbt_internal_test