# Write your MySQL query statement below
with max_salary as (
    select 
        company_id,
        max(salary) as max_salary
    from 
        Salaries
    group by 
        company_id
)
select 
    b.company_id,
    b.employee_id,
    b.employee_name,
    case when a.max_salary > 10000 then round(b.salary * 0.51)
        when a.max_salary >= 1000 then round(b.salary * 0.76)
        else b.salary end as salary 
from 
    max_salary a 
inner join 
    Salaries b 
on
    a.company_id = b.company_id