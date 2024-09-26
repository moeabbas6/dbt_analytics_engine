select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_df1af967688471520586c93428c7d0f6`
    
      limit 1000
    ) dbt_internal_test