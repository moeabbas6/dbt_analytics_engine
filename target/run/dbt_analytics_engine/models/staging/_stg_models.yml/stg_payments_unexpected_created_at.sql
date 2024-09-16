select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`stg_payments_unexpected_created_at`
    
      limit 20
    ) dbt_internal_test