select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`assert_positive_amounts_fct_pa_3aa360f449a3cbaaf0d4327788346420`
    
      limit 20
    ) dbt_internal_test