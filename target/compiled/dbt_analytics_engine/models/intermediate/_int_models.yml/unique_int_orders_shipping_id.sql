
    
    

with dbt_test__target as (

  select shipping_id as unique_field
  from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_orders`
  where shipping_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


