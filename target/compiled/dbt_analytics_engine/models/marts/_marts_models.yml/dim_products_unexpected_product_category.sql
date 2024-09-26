
    
    

with all_values as (

    select
        product_category as value_field,
        count(*) as n_records

    from `moes-dbt-layer`.`product`.`dim_products`
    group by product_category

)

select *
from all_values
where value_field not in (
    'Design Templates','Fonts & Typography','Graphic Assets','Stock Photography','Video & Animation'
)


