# Write your MySQL query statement below
with base as (
    select 
        distinct
        department,
        max(salary) over (partition by department) as sal
    from 
        Salaries
    where 
        department in ('Marketing','Engineering')
)
select 
    max(sal) - min(sal) as salary_difference
from 
    base