select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`relationships_fct_payment_meth_0683abd124324eb777cc740e1f6a852b`
    
      limit 20
    ) dbt_internal_test