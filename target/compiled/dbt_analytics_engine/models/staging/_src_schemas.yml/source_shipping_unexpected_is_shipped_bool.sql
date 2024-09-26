
    
    

with all_values as (

    select
        is_shipped as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`dae_sources`.`shipping`
    group by is_shipped

)

select *
from all_values
where value_field not in (
    True,False
)


