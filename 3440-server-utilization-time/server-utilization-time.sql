# Write your MySQL query statement below
with base as (
        select 
            server_id,
            status_time,
            row_number() over (partition by server_id, session_status order by status_time) as sess
        from 
            Servers
),
sess_info as (
    select 
        server_id,
        status_time,
        sess
    from (
        select 
            server_id,
            status_time,
            sess,
            count(server_id) over (partition by server_id, sess) as cnts
        from 
            base
    ) a
    where 
        cnts = 2
)
select 
    floor(sum(sums)/(3600 * 24)) as total_uptime_days
from (
    select 
        timestampdiff(second,min(status_time),max(status_time)) as sums
    from 
        sess_info
    group by 
        server_id, sess
) a