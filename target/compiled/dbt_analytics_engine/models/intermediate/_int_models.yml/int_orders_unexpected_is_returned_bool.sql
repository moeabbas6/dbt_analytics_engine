
    
    

with all_values as (

    select
        is_returned as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`staging`.`int_orders`
    group by is_returned

)

select *
from all_values
where value_field not in (
    True,False
)


