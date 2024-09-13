
    
    

with all_values as (

    select
        payment_status as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payment_lvl_joined`
    group by payment_status

)

select *
from all_values
where value_field not in (
    'successful','failed'
)


