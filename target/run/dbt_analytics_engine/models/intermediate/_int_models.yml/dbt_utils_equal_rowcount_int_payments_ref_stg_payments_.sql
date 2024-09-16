select
      sum(coalesce(diff_count, 0)) as failures,
      sum(coalesce(diff_count, 0)) >1 as should_warn,
      sum(coalesce(diff_count, 0)) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_equal_rowcount_int_payments_ref_stg_payments_`
    
      limit 20
    ) dbt_internal_test