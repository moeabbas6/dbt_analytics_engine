select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_84c988f10df9b19958dab313eba7cefd`
    
      limit 20
    ) dbt_internal_test