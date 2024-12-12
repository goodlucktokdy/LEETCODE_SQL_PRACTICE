# Write your MySQL query statement below
with base as (
    select 
        a.server_id,
        a.sessions,
        max(case when a.session_status = 'start' then a.status_time else null end) as start_time,
        max(case when a.session_status = 'stop' then a.status_time else null end) as stop_time
    from (
        select 
            distinct
            server_id,
            status_time,
            session_status,
            sum(case when session_status = 'start' then 1 else 0 end) over (partition by server_id order by status_time) as sessions
        from 
            Servers
    ) a 
    group by 
        1,2
), minutes_cte as (
    select 
        sum(a.diff_of_minute) as sum_minute
    from (
        select 
            server_id,
            sessions,
            start_time,
            stop_time,
            timestampdiff(minute,start_time,stop_time) as diff_of_minute
        from 
            base
    ) a 
)
select 
    floor(sum_minute/1440) as total_uptime_days
from 
    minutes_cte