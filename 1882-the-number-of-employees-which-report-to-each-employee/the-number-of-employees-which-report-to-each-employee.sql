# Write your MySQL query statement below
select 
    a.employee_id,
    a.name,
    count(distinct b.employee_id) as reports_count,
    round(avg(b.age)) as average_age
from 
    Employees a 
left join
    Employees b 
on 
    a.employee_id = b.reports_to
where 
    b.reports_to is not null
group by 
    1,2
order by 
    a.employee_id