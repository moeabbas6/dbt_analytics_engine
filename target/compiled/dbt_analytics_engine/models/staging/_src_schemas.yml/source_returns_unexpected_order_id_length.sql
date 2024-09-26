




    with grouped_expression as (
    select
        
        
    
  

    length(
        order_id
    ) = 36 as expression


    from `moes-dbt-layer`.`dae_sources`.`returns`
    

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




