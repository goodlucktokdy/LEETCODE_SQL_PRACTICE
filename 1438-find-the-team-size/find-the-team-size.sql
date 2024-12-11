# Write your MySQL query statement below
with base as (
    select 
        team_id,
        count(distinct employee_id) as cnts
    from 
        Employee
    group by 
        team_id
)
select 
    b.employee_id,
    a.cnts as team_size
from 
    base a 
inner join 
    Employee b 
on 
    a.team_id = b.team_id
