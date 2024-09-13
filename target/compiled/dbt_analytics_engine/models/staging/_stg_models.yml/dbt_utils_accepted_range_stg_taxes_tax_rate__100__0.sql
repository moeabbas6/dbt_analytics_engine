

with meet_condition as(
  select *
  from `moes-dbt-layer`.`dbt_analytics_engine_dev`.`stg_taxes`
),

validation_errors as (
  select *
  from meet_condition
  where
    -- never true, defaults to an empty result set. Exists to ensure any combo of the `or` clauses below succeeds
    1 = 2
    -- records with a value >= min_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not tax_rate >= 0
    -- records with a value <= max_value are permitted. The `not` flips this to find records that don't meet the rule.
    or not tax_rate <= 100
)

select *
from validation_errors

