
    
    

with all_values as (

    select
        is_nps as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`dae_sources`.`nps`
    group by is_nps

)

select *
from all_values
where value_field not in (
    True,False
)


