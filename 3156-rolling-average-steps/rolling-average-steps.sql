with base as (
    select 
        user_id,
        steps_count,
        steps_date,
        avg(steps_count) over (partition by user_id order by steps_date rows between 2 preceding and current row) as rolling_average,
        lag(steps_date,2) over (partition by user_id order by steps_date) as prev_date
    from 
        Steps
)
select 
    user_id,
    steps_date,
    round(rolling_average,2) as rolling_average
from 
    base 
where 
    datediff(steps_date,prev_date) + 1 = 3
order by 
    user_id, steps_date