select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`relationships_int_payments_a119759a6fc2755834df1eefbb54b2e7`
    
      limit 20
    ) dbt_internal_test