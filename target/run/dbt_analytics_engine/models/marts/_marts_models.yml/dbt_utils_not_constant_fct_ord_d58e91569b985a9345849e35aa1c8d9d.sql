select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_d58e91569b985a9345849e35aa1c8d9d`
    
      limit 20
    ) dbt_internal_test