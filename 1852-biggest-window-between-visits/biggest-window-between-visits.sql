with base as (
    select
        user_id,
        lag(visit_date) over (partition by user_id order by visit_date) as prev_visit,
        visit_date,
        timestampdiff(day,lag(visit_date) over (partition by user_id order by visit_date),visit_date) as diff_of_days,
        timestampdiff(day,max(visit_date) over (partition by user_id),'2021-01-01') as diff_today 
    from 
        UserVisits
)
select
    user_id,
    max(case when coalesce(diff_of_days,0) > diff_today then diff_of_days 
        else diff_today end) as biggest_window
from 
    base
group by 
    user_id