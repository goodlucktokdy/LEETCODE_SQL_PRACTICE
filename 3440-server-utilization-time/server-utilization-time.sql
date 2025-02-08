# Write your MySQL query statement below
with base as (
    select 
        server_id,
        timestampdiff(minute,min(status_time),max(status_time)) as diff_minute
    from (
        select 
            server_id,
            status_time,
            row_number() over (partition by server_id,session_status order by status_time) as sess
        from 
            Servers
    ) a
    group by 
        sess,server_id
)
select 
    floor(sum(diff_minute)/(60*24)) as total_uptime_days
from 
    base
