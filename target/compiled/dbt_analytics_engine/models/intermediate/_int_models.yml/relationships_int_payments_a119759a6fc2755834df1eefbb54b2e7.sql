
    
    

with child as (
    select country_id as from_field
    from `moes-dbt-layer`.`staging`.`int_payments`
    where country_id is not null
),

parent as (
    select country_id as to_field
    from `moes-dbt-layer`.`staging`.`stg_taxes`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


