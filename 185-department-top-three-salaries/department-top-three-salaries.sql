# Write your MySQL query statement below
select 
    Department,
    Employee,
    Salary
from (
    select 
        a.name as Department,
        b.name as Employee,
        b.salary as Salary,
        dense_rank() over (partition by b.departmentId order by b.salary desc) as ranks
    from 
        Department a 
    inner join 
        Employee b 
    on 
        a.id = b.departmentId
) a 
where 
    ranks <= 3 
