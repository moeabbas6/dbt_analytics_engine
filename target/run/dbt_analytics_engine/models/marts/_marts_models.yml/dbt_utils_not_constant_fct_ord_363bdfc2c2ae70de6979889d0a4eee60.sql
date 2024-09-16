select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_363bdfc2c2ae70de6979889d0a4eee60`
    
      limit 20
    ) dbt_internal_test