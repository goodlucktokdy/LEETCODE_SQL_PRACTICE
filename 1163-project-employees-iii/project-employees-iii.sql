# Write your MySQL query statement below
select 
    project_id,
    employee_id
from (
    select 
        a.project_id,
        a.employee_id,
        b.experience_years,
        dense_rank() over (partition by a.project_id order by b.experience_years desc) as ranks
    from 
        Project a 
    inner join 
        Employee b 
    on 
        a.employee_id = b.employee_id 
) a 
where 
    ranks = 1