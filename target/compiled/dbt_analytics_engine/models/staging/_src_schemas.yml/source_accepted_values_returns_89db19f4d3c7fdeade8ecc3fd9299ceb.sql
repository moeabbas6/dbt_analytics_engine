
    
    

with all_values as (

    select
        return_reason as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`returns`
    group by return_reason

)

select *
from all_values
where value_field not in (
    'Not as Described','Compatibility Issues','Quality Concerns','Technical Difficulties'
)


