# Write your MySQL query statement below
with base as (
    select 
        emp_id,
        emp_name,
        dep_id,
        position,
        dense_rank() over (order by dep_cnts desc) as ranks
    from (
        select 
            emp_id,
            emp_name,
            dep_id,
            count(emp_id) over (partition by dep_id) as dep_cnts,
            position
        from 
            Employees
    ) a
)
select 
    emp_name as manager_name,
    dep_id
from 
    base 
where 
    ranks = 1 and position = 'Manager'
order by 
    dep_id asc
