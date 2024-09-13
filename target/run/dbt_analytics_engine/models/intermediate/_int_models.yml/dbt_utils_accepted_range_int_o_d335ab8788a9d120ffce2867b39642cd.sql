select
      count(*) as failures,
      count(*) >10 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`dbt_utils_accepted_range_int_o_d335ab8788a9d120ffce2867b39642cd`
    
      limit 100
    ) dbt_internal_test