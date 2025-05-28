{{ config(materialized="view") }}

select
    employee_id,
    first_name,
    last_name,
    department,
    hire_date,
    phone_number,
    manager_id,
    job_id,
    salary,
    valid_from,
    valid_to,
    current_flag
from {{ ref('dim_employee_history') }}
where valid_to = '9999-12-31'
