-- models/dimensions/dim_org_hierarchy.sql
{{ config(materialized="table") }}

with
    org_hier as (
        select
            lpad('>', level * 2) || first_name || ' ' || last_name as employee_name,
            sys_connect_by_path(
                first_name || ' ' || last_name || ' (' || job_id || ')', ' / '
            ) as hierarchy_path,
            sys_connect_by_path(employee_id, ' / ') as hierarchy_path_emp_id,
            employee_id,
            manager_id,
            level
        from {{ ref("employee_snapshot") }}
        where dbt_valid_to is null start
        with manager_id is null connect by prior employee_id = manager_id
    )
select *
from org_hier
