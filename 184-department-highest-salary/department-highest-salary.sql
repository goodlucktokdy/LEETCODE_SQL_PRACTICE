-- select d.name Department, e.name Employee, e.salary Salary
-- from Employee e
-- inner join
-- Department d
-- on
--     e.departmentId = d.id
-- where
--     (e.departmentId, salary) in (select departmentId, max(salary) from Employee
--                 group by departmentId)
with t1 as
    (
    select distinct 
        d.name Department, 
        (
            case 
                when rank() over (partition by departmentId order by salary desc) = 1 then e.name
                end
        ) as Employee, 
        first_value(salary) over (partition by departmentId order by salary desc) Salary
    from 
        Employee e
    inner join
        Department d on e.departmentId = d.id
    )
    select 
        Department, Employee, Salary
    from
        t1 
    where
        Employee is not null