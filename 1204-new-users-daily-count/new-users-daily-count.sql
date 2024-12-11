# Write your MySQL query statement below
select
    a.first_visit as login_date,
    count(distinct user_id) as user_count
from (
    select 
        distinct
        user_id,
        min(activity_date) over (partition by user_id) as first_visit
    from 
        Traffic
    where 
        activity = 'login'
) a
where 
    timestampdiff(day,a.first_visit,'2019-06-30') <= 90
group by 
    login_date
