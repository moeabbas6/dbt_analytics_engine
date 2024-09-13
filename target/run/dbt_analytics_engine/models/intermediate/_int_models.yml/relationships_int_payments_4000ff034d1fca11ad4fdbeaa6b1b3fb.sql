select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`relationships_int_payments_4000ff034d1fca11ad4fdbeaa6b1b3fb`
    
      limit 20
    ) dbt_internal_test