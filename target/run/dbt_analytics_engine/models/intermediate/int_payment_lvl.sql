

  create or replace view `moes-dbt-layer`.`dbt_analytics_engine_dev`.`int_payment_lvl`
  OPTIONS(
      description=""""""
    )
  as WITH
  stg_payments AS (
    SELECT *
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_payments`)


  ,stg_taxes AS (
    SELECT * 
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_taxes`)


  ,stg_payment_fees AS (
    SELECT * 
      FROM `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_payment_fees`)


  ,final AS (
    SELECT order_id
          ,payment_id
          ,payment_method
          ,payment_status
          ,country_id
          ,country
          ,created_at
          ,gross_revenue
          ,tax_rate
          ,percentage_fee
          ,fixed_fee
          ,ROUND((gross_revenue * (percentage_fee / 100)) + fixed_fee, 2) AS payment_fee
      FROM stg_payments
      LEFT JOIN stg_taxes USING (country_id)
      LEFT JOIN stg_payment_fees USING (payment_method))


  SELECT *
    FROM final;

