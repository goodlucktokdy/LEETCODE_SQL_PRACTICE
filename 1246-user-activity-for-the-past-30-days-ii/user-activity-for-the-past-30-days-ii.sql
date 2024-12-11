# Write your MySQL query statement below
select 
    coalesce(round(avg(a.average_sessions),2),0) as average_sessions_per_user
from (
    select 
        user_id,
        count(distinct session_id) as average_sessions
    from
        Activity 
    where 
        timestampdiff(day,activity_date,'2019-07-27') < 30
    group by 
        user_id
) a
