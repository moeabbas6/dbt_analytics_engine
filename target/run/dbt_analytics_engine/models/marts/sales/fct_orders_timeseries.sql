-- back compat for old kwarg name
  
  
        
            
            
        
    

    

    merge into `moes-dbt-layer`.`sales`.`fct_orders_timeseries` as DBT_INTERNAL_DEST
        using (
        select
        * from `moes-dbt-layer`.`sales`.`fct_orders_timeseries__dbt_tmp`
        ) as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.date = DBT_INTERNAL_DEST.date
            )

    
    when matched then update set
        `date` = DBT_INTERNAL_SOURCE.`date`,`sales` = DBT_INTERNAL_SOURCE.`sales`,`sales_wma_7` = DBT_INTERNAL_SOURCE.`sales_wma_7`,`sales_sma_7` = DBT_INTERNAL_SOURCE.`sales_sma_7`,`sales_sma_14` = DBT_INTERNAL_SOURCE.`sales_sma_14`,`sales_sma_30` = DBT_INTERNAL_SOURCE.`sales_sma_30`,`sales_sma_60` = DBT_INTERNAL_SOURCE.`sales_sma_60`,`sales_sma_120` = DBT_INTERNAL_SOURCE.`sales_sma_120`,`sales_sma_upper_7` = DBT_INTERNAL_SOURCE.`sales_sma_upper_7`,`sales_sma_lower_7` = DBT_INTERNAL_SOURCE.`sales_sma_lower_7`,`sales_sma_upper_14` = DBT_INTERNAL_SOURCE.`sales_sma_upper_14`,`sales_sma_lower_14` = DBT_INTERNAL_SOURCE.`sales_sma_lower_14`,`sales_sma_upper_30` = DBT_INTERNAL_SOURCE.`sales_sma_upper_30`,`sales_sma_lower_30` = DBT_INTERNAL_SOURCE.`sales_sma_lower_30`,`sales_sma_upper_60` = DBT_INTERNAL_SOURCE.`sales_sma_upper_60`,`sales_sma_lower_60` = DBT_INTERNAL_SOURCE.`sales_sma_lower_60`,`sales_sma_upper_120` = DBT_INTERNAL_SOURCE.`sales_sma_upper_120`,`sales_sma_lower_120` = DBT_INTERNAL_SOURCE.`sales_sma_lower_120`
    

    when not matched then insert
        (`date`, `sales`, `sales_wma_7`, `sales_sma_7`, `sales_sma_14`, `sales_sma_30`, `sales_sma_60`, `sales_sma_120`, `sales_sma_upper_7`, `sales_sma_lower_7`, `sales_sma_upper_14`, `sales_sma_lower_14`, `sales_sma_upper_30`, `sales_sma_lower_30`, `sales_sma_upper_60`, `sales_sma_lower_60`, `sales_sma_upper_120`, `sales_sma_lower_120`)
    values
        (`date`, `sales`, `sales_wma_7`, `sales_sma_7`, `sales_sma_14`, `sales_sma_30`, `sales_sma_60`, `sales_sma_120`, `sales_sma_upper_7`, `sales_sma_lower_7`, `sales_sma_upper_14`, `sales_sma_lower_14`, `sales_sma_upper_30`, `sales_sma_lower_30`, `sales_sma_upper_60`, `sales_sma_lower_60`, `sales_sma_upper_120`, `sales_sma_lower_120`)


    