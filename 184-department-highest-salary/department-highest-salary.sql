select d.name Department, e.name Employee, e.salary Salary
from Employee e
inner join
Department d
on
    e.departmentId = d.id
where
    (e.departmentId, salary) in (select departmentId, max(salary) from Employee
                group by departmentId)