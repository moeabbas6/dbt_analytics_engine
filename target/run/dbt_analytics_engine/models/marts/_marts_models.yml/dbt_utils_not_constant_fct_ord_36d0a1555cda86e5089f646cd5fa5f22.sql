select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_36d0a1555cda86e5089f646cd5fa5f22`
    
      limit 1000
    ) dbt_internal_test