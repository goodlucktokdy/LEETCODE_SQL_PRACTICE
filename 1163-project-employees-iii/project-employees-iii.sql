# Write your MySQL query statement below
select 
    project_id,
    employee_id
from (
    select 
        a.project_id,
        a.employee_id,
        dense_rank() over (partition by a.project_id order by coalesce(b.experience_years,0) desc) as ranks
    from 
        Project a 
    left join 
        Employee b 
    on 
        a.employee_id = b.employee_id
) c
where 
    ranks = 1