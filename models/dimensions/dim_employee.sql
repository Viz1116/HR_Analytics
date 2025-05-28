{{ config(materialized='incremental', 
        unique_key='employee_id',
        on_schema_change='sync_all_columns') }}

with latest_records as (
    select *
    from {{ ref('employee_snapshot') }}
    where dbt_valid_to is null
)

select
    employee_id,
    first_name,
    last_name,
    department_name as department,
    hire_date,
    phone_number,
    manager_id,
    salary,
    dbt_valid_from as valid_from,
    coalesce(dbt_valid_to, '9999-12-31') as valid_to,
    true as is_current
from latest_records