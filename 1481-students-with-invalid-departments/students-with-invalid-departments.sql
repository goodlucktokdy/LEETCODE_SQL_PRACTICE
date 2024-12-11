# Write your MySQL query statement below
select 
    a.id,
    a.name
from 
    Students a 
left join 
    Departments b 
on 
    a.department_id = b.id
where 
    b.id is null