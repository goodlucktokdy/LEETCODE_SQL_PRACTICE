# Write your MySQL query statement below
with base as (
    select 
        user_id,
        visit_date
    from 
        UserVisits
    union all
    select 
        user_id,
        '2021-01-01' as visit_date
    from 
        UserVisits
),
diff_info as (
    select 
        user_id,
        timestampdiff(day,prev_visit,visit_date) as diff_date,
        visit_date
    from (
        select 
            user_id,
            lag(visit_date) over (partition by user_id order by visit_date) as prev_visit,
            visit_date
        from 
            base
    ) a
)
select 
    user_id,
    max(diff_date) as biggest_window
from 
    diff_info
group by 
    user_id 
order by 
    user_id