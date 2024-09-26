select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_d0a225e71dc2a317acffbf2075634182`
    
      limit 1000
    ) dbt_internal_test