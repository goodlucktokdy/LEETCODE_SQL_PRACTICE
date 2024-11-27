# Write your MySQL query statement below
select 
    distinct
    a.employee_id
from (
    select 
        employee_id,
        manager_id,
        salary
    from 
        Employees
    where 
            manager_id not in (select employee_id from Employees) 
        and 
            manager_id is not null
        and 
            salary < 30000
) a
order by
    a.employee_id