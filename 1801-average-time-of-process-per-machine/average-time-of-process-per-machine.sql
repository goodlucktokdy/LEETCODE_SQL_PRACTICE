# Write your MySQL query statement below
with base as (
    select 
        machine_id,
        process_id,
        (last_value(timestamp) over (partition by machine_id,process_id order by timestamp)- first_value(timestamp) over (partition by machine_id, process_id order by timestamp)) as diff_of_time,
        timestamp
    from 
        Activity
)
select 
    machine_id,
    round(avg(diff_of_time),3) as processing_time
from 
    base
where 
    diff_of_time != 0
group by 
    machine_id