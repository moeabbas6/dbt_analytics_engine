select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`assert_positive_amounts_fct_pa_5e00436bf816312dda3e63c42710efb0`
    
      limit 20
    ) dbt_internal_test