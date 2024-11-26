# Write your MySQL query statement below
with base as (
    select 
        a.project_id,
        a.employee_id,
        b.name,
        b.experience_years
    from 
        Project a 
    left join 
        Employee b
    on 
        a.employee_id = b.employee_id
)
select 
    distinct
    project_id,
    round(avg(experience_years),2) as average_years
from 
    base 
group by 
    project_id