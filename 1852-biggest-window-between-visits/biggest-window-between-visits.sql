with base as (
    select
        user_id,
        visit_date,
        lead(visit_date) over (partition by user_id order by visit_date) as next_visit
    from 
        UserVisits
)
select
    user_id,
    max(timestampdiff(day,visit_date,ifnull(next_visit,'2021-01-01'))) as biggest_window
from 
    base
group by 
    user_id
order by 
    user_id