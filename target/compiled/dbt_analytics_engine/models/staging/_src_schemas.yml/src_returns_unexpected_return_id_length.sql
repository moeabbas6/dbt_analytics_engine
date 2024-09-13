




    with grouped_expression as (
    select
        
        
    
  

    length(
        return_id
    ) = 36 as expression


    from `moes-dbt-layer`.`dbt_analytics_engine_sources`.`returns`
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors




