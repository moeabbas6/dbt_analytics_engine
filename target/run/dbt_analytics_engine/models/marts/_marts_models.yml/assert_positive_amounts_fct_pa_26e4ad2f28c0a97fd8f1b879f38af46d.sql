select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`assert_positive_amounts_fct_pa_26e4ad2f28c0a97fd8f1b879f38af46d`
    
      limit 20
    ) dbt_internal_test