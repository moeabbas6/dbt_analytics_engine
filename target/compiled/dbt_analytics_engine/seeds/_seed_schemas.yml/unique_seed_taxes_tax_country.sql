
    
    

with dbt_test__target as (

  select tax_country as unique_field
  from `moes-dbt-layer`.`seeds`.`seed_taxes`
  where tax_country is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


