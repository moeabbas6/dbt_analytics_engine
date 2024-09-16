
    
    

with child as (
    select payment_method as from_field
    from `moes-dbt-layer`.`staging`.`int_payments`
    where payment_method is not null
),

parent as (
    select payment_method as to_field
    from `moes-dbt-layer`.`staging`.`stg_payment_fees`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


