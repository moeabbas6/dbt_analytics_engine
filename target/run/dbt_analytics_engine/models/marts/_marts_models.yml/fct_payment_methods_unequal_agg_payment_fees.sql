select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`fct_payment_methods_unequal_agg_payment_fees`
    
      limit 20
    ) dbt_internal_test