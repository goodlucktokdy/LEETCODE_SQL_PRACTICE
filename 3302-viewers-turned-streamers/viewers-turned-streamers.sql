# Write your MySQL query statement below
with base as (
    select 
        user_id,
        session_start,
        session_end,
        session_id,
        session_type,
        row_number() over (partition by user_id order by session_start asc) as rnums
    from 
        Sessions 
)
select 
    user_id,
    count(distinct session_id) as sessions_count
from 
    base
where 
    user_id in (select user_id from base where rnums = 1 and session_type = 'Viewer')
    and session_type = 'Streamer' 
group by 
    user_id
order by 
    sessions_count desc, user_id desc