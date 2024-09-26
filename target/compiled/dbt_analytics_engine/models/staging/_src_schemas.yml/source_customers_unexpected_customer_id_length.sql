




    with grouped_expression as (
    select
        
        
    
  

    length(
        customer_id
    ) = 36 as expression


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




