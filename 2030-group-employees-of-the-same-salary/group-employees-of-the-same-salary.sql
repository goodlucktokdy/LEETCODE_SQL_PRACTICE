# Write your MySQL query statement below
select 
    distinct 
    a.employee_id,
    a.name,
    a.salary,
    dense_rank() over (order by a.salary asc) as team_id
from 
    Employees a 
inner join 
    Employees b 
on 
    a.salary = b.salary and a.employee_id != b.employee_id
order by 
    team_id asc, employee_id asc