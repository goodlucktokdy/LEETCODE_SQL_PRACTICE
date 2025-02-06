# Write your MySQL query statement below
with base as (
    select 
        user_id,
        min(activity_date) over (partition by user_id) as login_date
    from (
        select 
            user_id,
            activity,
            activity_date
        from 
            Traffic 
    ) a 
    where 
        activity = 'login'
)
select 
    login_date,
    count(distinct user_id) as user_count
from 
    base 
where 
    date_sub('2019-06-30',interval 90 day) <= login_date
group by 
    login_date