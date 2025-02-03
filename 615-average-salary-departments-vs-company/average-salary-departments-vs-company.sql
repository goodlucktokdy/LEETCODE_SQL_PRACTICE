# Write your MySQL query statement below
with salary_info as (
    select 
        date_format(a.pay_date,'%Y-%m') as pay_month,
        a.employee_id,
        b.department_id,
        avg(a.amount) over (partition by date_format(a.pay_date,'%Y-%m'),b.department_id) as dept_avg,
        avg(a.amount) over (partition by date_format(a.pay_date,'%Y-%m')) as company_avg
    from 
        Salary a 
    inner join 
        Employee b 
    on 
        a.employee_id = b.employee_id
)
select 
    distinct
    pay_month,
    department_id,
    case when dept_avg > company_avg then 'higher'
        when dept_avg < company_avg then 'lower' else 'same' end as comparison
from 
    salary_info