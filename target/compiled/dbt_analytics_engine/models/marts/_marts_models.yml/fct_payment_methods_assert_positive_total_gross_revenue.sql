



select
    *
from `moes-dbt-layer`.`finance`.`fct_payment_methods`

where not(total_gross_revenue > 0)

