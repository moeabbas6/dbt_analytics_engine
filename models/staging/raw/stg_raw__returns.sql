

WITH
  stg_raw__returns AS (
    SELECT order_id
          ,return_id
          ,is_returned
          ,return_date
          ,return_reason
      FROM {{ source("raw", "returns")}}
      WHERE return_date < CURRENT_DATE
        {% if target.name != 'prod' -%}
        AND return_date > CURRENT_DATE - INTERVAL 7 DAY
        {%- endif %})


  SELECT *
    FROM stg_raw__returns