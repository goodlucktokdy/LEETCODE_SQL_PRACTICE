
with base as (
    select 
        user_id,
        row_number() over (partition by user_id order by session_start asc) as rnums,
        session_id,
        session_type
    from 
        Sessions
)
select 
    user_id,
    count(distinct session_id) as sessions_count
from 
    base a 
where exists 
    (select 1 from base b 
        where a.user_id = b.user_id and b.rnums = 1 and b.session_type = 'Viewer')
and 
    session_type = 'Streamer'
group by 
    user_id 
order by 
    sessions_count desc, user_id desc