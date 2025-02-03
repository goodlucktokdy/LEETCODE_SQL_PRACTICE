with recursive cte as (
    select 
        employee_id,
        employee_name,
        manager_id,
        0 as hierarchy_level,
        salary
    from 
        Employees 
    where 
        manager_id is null
    union all
    select 
        a.employee_id,
        a.employee_name,
        a.manager_id,
        cte.hierarchy_level + 1,
        a.salary
    from
        Employees a
    inner join 
        cte 
    on
        a.manager_id = cte.employee_id
)
select 
    subordinate_id,
    subordinate_name,
    hierarchy_level,
    salary_difference
from (
    select 
        employee_id as subordinate_id,
        employee_name as subordinate_name,
        hierarchy_level,
        salary - max(salary) over () as salary_difference
    from 
        cte 
) a 
where 
    hierarchy_level > 0 
order by 
    hierarchy_level asc, subordinate_id asc 