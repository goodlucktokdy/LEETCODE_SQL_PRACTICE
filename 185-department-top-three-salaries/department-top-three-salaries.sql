# Write your MySQL query statement below
with base as (
    select 
        b.name as Department,
        a.departmentId,
        a.id,
        a.name,
        a.salary
    from 
        Employee a 
    left join 
        Department b 
    on 
        a.departmentId = b.id
)
select 
    distinct
    a.Department,
    a.Employee,
    a.Salary
from (
    select 
        Department,
        departmentId,
        dense_rank() over (partition by departmentId order by salary desc) as ranks,
        name as Employee,
        salary as Salary
    from 
        base
) a
where 
    ranks <= 3