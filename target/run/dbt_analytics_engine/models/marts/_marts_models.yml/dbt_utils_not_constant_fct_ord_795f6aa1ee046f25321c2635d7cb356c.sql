select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_795f6aa1ee046f25321c2635d7cb356c`
    
      limit 1000
    ) dbt_internal_test