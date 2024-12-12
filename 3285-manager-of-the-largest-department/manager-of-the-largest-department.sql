# Write your MySQL query statement below
with base as (
    select 
        dep_id,
        dense_rank() over (order by count(*) desc) as ranks
    from 
        Employees
    group by 
        dep_id
)
select 
    distinct
    b.emp_name as manager_name,
    a.dep_id
from 
    base a
inner join 
    Employees b 
on 
    a.dep_id = b.dep_id
where 
    a.ranks = 1 and b.position = 'Manager'
order by 
    a.dep_id asc