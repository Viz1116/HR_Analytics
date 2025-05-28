{{ config(materialized="view") }}

with
    emp as (select * from {{ source("HR_DATA", "HR_EMPLOYEES") }},),
    dept as (select * from {{ source("HR_DATA", "HR_DEPARTMENTS") }}),
    jobs as (select * from {{ source("HR_DATA", "HR_JOBS") }}),
    employee as (
        select
            emp.employee_id,
            emp.first_name,
            emp.last_name,
            emp.email,
            emp.phone_number,
            emp.hire_date,
            emp.manager_id,
            emp.salary,
            emp.job_id,
            emp.department_id,
            dept.department_name,
            current_timestamp as created_when
        from emp
        left join dept on emp.department_id = dept.department_id
        left join jobs on emp.job_id = jobs.job_id
    -- where _fivetran_deleted = false  -- exclude deleted records
    )
select *
from employee
