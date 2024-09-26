
    
    

with all_values as (

    select
        customer_type as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`sales`.`fct_orders`
    group by customer_type

)

select *
from all_values
where value_field not in (
    'Returning','New'
)


