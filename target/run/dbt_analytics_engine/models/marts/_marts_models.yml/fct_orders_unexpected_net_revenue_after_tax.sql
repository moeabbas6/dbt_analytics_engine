select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`fct_orders_unexpected_net_revenue_after_tax`
    
      limit 20
    ) dbt_internal_test