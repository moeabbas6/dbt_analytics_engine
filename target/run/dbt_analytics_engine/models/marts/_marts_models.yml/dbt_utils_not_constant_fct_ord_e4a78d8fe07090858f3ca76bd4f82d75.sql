select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_e4a78d8fe07090858f3ca76bd4f82d75`
    
      limit 20
    ) dbt_internal_test