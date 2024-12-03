with base as (
    select
        b.project_id,
        a.employee_id,
        max(a.experience_years) over (partition by b.project_id) as max_years
    from 
        Employee a
    left join
        Project b
    on
        a.employee_id = b.employee_id
)
select
    a.project_id,
    b.employee_id
from 
    base a 
inner join
    Employee b
on
    a.employee_id = b.employee_id
where
    b.experience_years = a.max_years and a.project_id is not null