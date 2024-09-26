
    
    

with dbt_test__target as (

  select payment_method_id as unique_field
  from `moes-dbt-layer`.`seeds`.`seed_payment_fees`
  where payment_method_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


