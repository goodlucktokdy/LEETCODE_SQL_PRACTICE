# Write your MySQL query statement below
select 
    company_id,
    employee_id,
    employee_name,
    round(case when max_sal > 10000 then salary * 0.51
        when max_sal between 1000 and 10000 then salary * 0.76
        else salary end) as salary
from (
    select 
        company_id,
        employee_id,
        employee_name,
        salary,
        max(salary) over (partition by company_id) as max_sal
    from 
        Salaries
) a 