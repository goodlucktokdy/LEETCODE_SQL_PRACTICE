# Write your MySQL query statement below
with base as (
    select 
        *,
        dense_rank() over (order by a.dept_size desc) as ranks
    from (
        select 
            count(emp_id) over (partition by dep_id) as dept_size,
            emp_id,
            dep_id,
            position
        from 
            Employees
    ) a
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
    a.emp_id = b.emp_id
where 
    a.ranks = 1 and a.position = 'Manager'
order by 
    a.dep_id asc