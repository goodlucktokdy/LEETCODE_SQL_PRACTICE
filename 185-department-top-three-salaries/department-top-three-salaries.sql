with base as (
    select 
        a.name as Department,
        b.name as Employee,
        a.salary as Salary,
        dense_rank() over (partition by a.departmentId order by a.salary desc) as ranks
    from 
        Employee a 
    inner join 
        Department b 
    on 
        a.departmentId = b.id 
)
select 
    Department,
    Employee,
    Salary
from 
    base 
where 
    ranks <= 3