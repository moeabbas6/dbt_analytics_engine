
    
    

with all_values as (

    select
        payment_method as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders`
    group by payment_method

)

select *
from all_values
where value_field not in (
    'amazon_pay','stripe','apple_pay','bitcoin'
)


