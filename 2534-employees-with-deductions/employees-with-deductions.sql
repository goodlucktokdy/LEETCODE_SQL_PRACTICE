# Write your MySQL query statement below
select 
    distinct 
    employee_id
from (
    select 
        a.employee_id,
        ceil(sum(coalesce(timestampdiff(second,b.in_time,b.out_time),0)) / 60)  as diff_minute,
        a.needed_hours
    from 
        Employees a 
    left join 
        Logs b 
    on 
        a.employee_id = b.employee_id
    group by 
        a.employee_id, a.needed_hours
) a 
where 
    diff_minute < needed_hours * 60