select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_pay_e8311164492a85011b25a15a86e84a09`
    
      limit 20
    ) dbt_internal_test