select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_dim_pro_41f89cc05d67c2834c5b1e3abe254e09`
    
      limit 20
    ) dbt_internal_test