select
    a.employee_id
from 
    Employees a
left join
    Salaries b
on 
    a.employee_id = b.employee_id
where
    b.salary is null
union
select
    a.employee_id
from 
    Salaries a
left join
    Employees b
on
    a.employee_id = b.employee_id
where
    b.name is null
order by 
    employee_id asc