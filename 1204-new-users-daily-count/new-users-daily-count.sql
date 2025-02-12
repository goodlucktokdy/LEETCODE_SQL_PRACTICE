# Write your MySQL query statement below
select 
    activity_date as login_date,
    count(distinct user_id) as user_count
from (
    select 
        user_id,
        activity,
        activity_date,
        dense_rank() over (partition by user_id order by activity_date asc) as ranks
    from 
        Traffic
    where 
        activity = 'login'
) a
where 
    ranks = 1 and date_sub('2019-06-30',interval 90 day) <= activity_date
group by 
    activity_date