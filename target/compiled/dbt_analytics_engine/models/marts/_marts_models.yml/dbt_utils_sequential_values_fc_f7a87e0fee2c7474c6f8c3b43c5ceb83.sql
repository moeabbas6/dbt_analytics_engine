





with windowed as (

    select
        
        date,
        lag(date) over (
            
            order by date
        ) as previous_date
    from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`fct_orders_timeseries_sma`
),

validation_errors as (
    select
        *
    from windowed
    
    where not(cast(date as timestamp)= cast(

        datetime_add(
            cast( previous_date as datetime),
        interval 1 day
        )

 as timestamp))
    
)

select *
from validation_errors

