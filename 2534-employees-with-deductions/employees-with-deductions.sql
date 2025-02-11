# Write your MySQL query statement below
with base as (
    select 
        employee_id,
        ceil(sum(timestampdiff(second,in_time,out_time)) / 60) as duration
    from 
        Logs
    group by 
        employee_id
)
select 
    distinct 
    employee_id
from (
    select 
        a.employee_id,
        a.needed_hours,
        coalesce(b.duration,0) as duration
    from 
        Employees a 
    left join 
        base b 
    on 
        a.employee_id = b.employee_id 
) a
where 
    needed_hours * 60 > duration 