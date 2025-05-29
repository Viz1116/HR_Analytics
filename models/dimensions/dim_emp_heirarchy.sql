{{ config(materialized="view") }}

select
    employee_id,
    manager_id,
    hierarchy_path,
    hierarchy_path_emp_id,
    split_part(hierarchy_path_emp_id, '/', 2) as level_1_id,
    split_part(hierarchy_path, '/', 2) as level_1_name,
    split_part(hierarchy_path_emp_id, '/', 3) as level_2_id,
    split_part(hierarchy_path, '/', 3) as level_2_name,
    split_part(hierarchy_path_emp_id, '/', 4) as level_3_id,
    split_part(hierarchy_path, '/', 4) as level_3_name,
    split_part(hierarchy_path_emp_id, '/', 5) as level_4_id,
    split_part(hierarchy_path, '/', 5) as level_4_name,
    split_part(hierarchy_path_emp_id, '/', 6) as level_5_id,
    split_part(hierarchy_path, '/', 6) as level_5_name,
    split_part(hierarchy_path_emp_id, '/', 7) as level_6_id,
    split_part(hierarchy_path, '/', 7) as level_6_name,
    split_part(hierarchy_path_emp_id, '/', 8) as level_7_id,
    split_part(hierarchy_path, '/', 8) as level_7_name
from {{ ref("dim_org_hierarchy") }}
where level_1 = 1000
