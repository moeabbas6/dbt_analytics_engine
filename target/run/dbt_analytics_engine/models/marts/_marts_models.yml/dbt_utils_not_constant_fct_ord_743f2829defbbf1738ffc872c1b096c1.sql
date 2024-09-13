select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_not_constant_fct_ord_743f2829defbbf1738ffc872c1b096c1`
    
      limit 20
    ) dbt_internal_test