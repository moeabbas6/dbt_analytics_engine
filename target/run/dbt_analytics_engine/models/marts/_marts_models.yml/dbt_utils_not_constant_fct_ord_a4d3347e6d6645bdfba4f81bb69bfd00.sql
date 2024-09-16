select
      count(*) as failures,
      count(*) >1 as should_warn,
      count(*) >20 as should_error
    from (
      
        select *
        from `moes-dbt-layer`.`failed_tests`.`dbt_utils_not_constant_fct_ord_a4d3347e6d6645bdfba4f81bb69bfd00`
    
      limit 20
    ) dbt_internal_test