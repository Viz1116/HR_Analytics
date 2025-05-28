{{ config(materialized="view", on_schema_change="sync_all_columns") }}

select
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    manager_id,
    salary,
    job_id,
    department_id,
    department_name,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to,
    true as is_current
from {{ ref("employee_snapshot") }}
where dbt_valid_to is null
