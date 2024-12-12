# Write your MySQL query statement below
select 
    max(a.sal) - min(a.sal) as salary_difference
from (
    select 
        distinct
        department,
        max(salary) over (partition by department) as sal
    from 
        Salaries
    where 
        department in ('Marketing','Engineering')
) a