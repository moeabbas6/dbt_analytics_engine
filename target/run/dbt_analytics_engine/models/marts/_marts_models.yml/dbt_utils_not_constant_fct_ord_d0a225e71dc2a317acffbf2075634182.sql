select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_not_constant_fct_ord_d0a225e71dc2a317acffbf2075634182`
    
      limit 20
    ) dbt_internal_test