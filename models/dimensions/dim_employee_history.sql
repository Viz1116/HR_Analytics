{{ config(materialized="incremental", unique_key=["employee_id", "valid_from"]) }}

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
    case when dbt_valid_to is null then true else false end as is_current
from {{ ref("employee_snapshot") }}
