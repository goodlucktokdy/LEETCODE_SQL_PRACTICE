select
    employee_id,
    if(employee_id % 2 = 1 and substring(name,1,1) != 'M', salary, 0) as bonus
from
    Employees
order by
    employee_id asc