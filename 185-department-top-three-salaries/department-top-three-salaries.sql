select 
    Department,
    Employee,
    Salary
from (
    select 
        b.name as Department,
        a.name as Employee,
        a.salary as Salary,
        dense_rank() over (partition by a.departmentId order by a.salary desc) as ranks
    from 
        Employee a 
    inner join 
        Department b 
    on 
        a.departmentId = b.id
) a
where 
    ranks <= 3
