
    with a as (
        
    select
        
        sum(gross_revenue) as expression
    from
        `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payments`
    where
        payment_method = 'stripe'
    
    

    ),
    b as (
        
    select
        
        sum(gross_revenue) as expression
    from
        `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_payments`
    where
        payment_method = 'stripe'
    
    

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
        