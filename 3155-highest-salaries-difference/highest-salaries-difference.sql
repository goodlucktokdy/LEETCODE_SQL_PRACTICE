# Write your MySQL query statement below
with base as (
    select 
        distinct
        department,
        max(salary) over (partition by department) as sal
    from 
        Salaries
)
select 
    abs(a.eng-a.mar) as salary_difference
from (
    select 
        max(case when department like '%Eng%' then sal end) as eng,
        max(case when department like '%Mar%' then sal end) as mar
    from 
        base
) a