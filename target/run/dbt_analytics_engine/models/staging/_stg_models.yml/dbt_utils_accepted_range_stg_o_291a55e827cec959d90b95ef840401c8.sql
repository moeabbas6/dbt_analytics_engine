select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_stg_o_291a55e827cec959d90b95ef840401c8`
    
      limit 100
    ) dbt_internal_test