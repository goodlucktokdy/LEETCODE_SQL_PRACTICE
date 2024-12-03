with base as (
    select
        b.name as Department,
        a.name as Employee,
        a.salary
    from 
        Employee a
    left join
        Department b
    on 
        b.id = a.departmentId
)
select
    a.Department,
    a.Employee,
    a.Salary
from (
    select
        Department,
        Employee,
        Salary,
        dense_rank() over (partition by Department order by salary desc) as ranks
    from 
        base
) a
where 
    ranks = 1