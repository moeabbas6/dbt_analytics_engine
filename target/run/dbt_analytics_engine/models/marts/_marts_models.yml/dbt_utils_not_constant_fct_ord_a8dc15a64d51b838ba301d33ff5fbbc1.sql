select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_a8dc15a64d51b838ba301d33ff5fbbc1`
    
      limit 20
    ) dbt_internal_test