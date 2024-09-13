
    
    

with child as (
    select shipping_id as from_field
    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_orders`
    where shipping_id is not null
),

parent as (
    select shipping_id as to_field
    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_shipping`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


