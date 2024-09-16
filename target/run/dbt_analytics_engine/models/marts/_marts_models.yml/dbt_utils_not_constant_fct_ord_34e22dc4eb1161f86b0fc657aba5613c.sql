select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_34e22dc4eb1161f86b0fc657aba5613c`
    
      limit 20
    ) dbt_internal_test