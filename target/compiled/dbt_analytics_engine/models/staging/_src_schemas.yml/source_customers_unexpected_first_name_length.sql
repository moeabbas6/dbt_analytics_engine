





    with grouped_expression as (
    select
        
        
    
  
( 1=1 and length(
        first_name
    ) >= 1 and length(
        first_name
    ) <= 16
)
 as expression


    from `moes-dbt-layer`.`dae_sources`.`customers`
    

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






