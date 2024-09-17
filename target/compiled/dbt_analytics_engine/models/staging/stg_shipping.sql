WITH
  stg_shipping AS (
    SELECT order_id
          ,shipping_id
          ,is_shipped
          ,shipping_date
          ,shipping_amount
      FROM `moes-dbt-layer`.`dae_sources`.`shipping`
      WHERE shipping_date < CURRENT_DATE
        AND shipping_date > CURRENT_DATE - INTERVAL 7 DAY)


  SELECT *
    FROM stg_shipping