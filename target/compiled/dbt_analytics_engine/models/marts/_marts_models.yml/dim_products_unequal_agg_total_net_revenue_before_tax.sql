
    with a as (
        
    select
        
        sum(total_net_revenue_before_tax) as expression
    from
        `moes-dbt-layer`.`product`.`dim_products`
    

    ),
    b as (
        
    select
        
        sum(net_revenue_before_tax) as expression
    from
        `moes-dbt-layer`.`sales`.`fct_orders`
    

    ),
    final as (

        select
            
            a.expression,
            b.expression as compare_expression,
            abs(coalesce(a.expression, 0) - coalesce(b.expression, 0)) as expression_difference,
            abs(coalesce(a.expression, 0) - coalesce(b.expression, 0))/
                nullif(a.expression * 1.0, 0) as expression_difference_percent
        from
        
            a cross join b
        
    )
    -- DEBUG:
    -- select * from final
    select
        *
    from final
    where
        
        expression_difference > 0.0
        