select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`dbt_analytics_engine_dev_failed_tests`.`fct_orders_valid_net_revenue_before_tax`
    
      limit 20
    ) dbt_internal_test