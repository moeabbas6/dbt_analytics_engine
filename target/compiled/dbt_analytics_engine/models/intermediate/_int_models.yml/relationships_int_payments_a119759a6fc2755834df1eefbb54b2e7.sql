
    
    

with child as (
    select country_id as from_field
    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payments`
    where country_id is not null
),

parent as (
    select country_id as to_field
    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_taxes`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


