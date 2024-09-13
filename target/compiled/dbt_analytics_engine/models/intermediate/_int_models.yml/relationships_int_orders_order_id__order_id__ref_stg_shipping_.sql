
    
    

with child as (
    select order_id as from_field
    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_orders`
    where order_id is not null
),

parent as (
    select order_id as to_field
    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_shipping`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


