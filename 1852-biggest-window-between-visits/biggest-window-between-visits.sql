# Write your MySQL query statement below
with base as (
    select 
        user_id,
        visit_date
    from 
        UserVisits
    union
    select 
        user_id,
        '2021-01-01' as visit_date
    from 
        UserVisits
),
diff_day as (
    select 
        user_id,
        timestampdiff(day,prev_visit,visit_date) as windows
    from (
        select 
            user_id,
            lag(visit_date) over (partition by user_id order by visit_date) as prev_visit,
            visit_date
        from 
            base
    ) a
    where 
        prev_visit is not null
)
select 
    user_id,
    max(windows) as biggest_window
from 
    diff_day
group by 
    user_id 
order by 
    user_id 