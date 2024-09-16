select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`fct_orders_unequal_agg_cogs`
    
      limit 20
    ) dbt_internal_test