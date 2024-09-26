WITH
  stg_shipping AS (
    SELECT order_id
          ,shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
      FROM `moes-dbt-layer`.`dae_sources`.`shipping`
      WHERE shipping_date < CURRENT_DATE
        )


  SELECT *
    FROM stg_shipping