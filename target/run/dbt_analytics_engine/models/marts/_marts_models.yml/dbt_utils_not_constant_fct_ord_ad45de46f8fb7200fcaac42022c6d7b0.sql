select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_ad45de46f8fb7200fcaac42022c6d7b0`
    
      limit 1000
    ) dbt_internal_test