with base as (
    select
        emp_id,
        event_day,
        (out_time - in_time) as duration
    from 
        Employees
)
select
    event_day as day,
    emp_id,
    sum(duration) as total_time
from 
    base
group by 
    1,2
