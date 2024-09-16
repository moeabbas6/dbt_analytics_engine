select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_f706fc49ea212b90838487f43b0b3d91`
    
      limit 20
    ) dbt_internal_test