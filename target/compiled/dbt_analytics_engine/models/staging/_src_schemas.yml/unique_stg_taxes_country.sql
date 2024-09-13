
    
    

with dbt_test__target as (

  select country as unique_field
  from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_taxes`
  where country is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


