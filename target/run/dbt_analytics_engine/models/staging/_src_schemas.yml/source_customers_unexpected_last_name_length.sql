select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`source_customers_unexpected_last_name_length`
    
      limit 20
    ) dbt_internal_test