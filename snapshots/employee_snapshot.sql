{% snapshot employee_snapshot %}

    {{
        config(
            target_schema="stage",
            unique_key="employee_id",
            strategy="check",
            check_cols=["department_id"],
            invalidate_hard_deletes=True,
        )
    }}

    select *
    from {{ ref("stg_hr_employees") }}

{% endsnapshot %}
