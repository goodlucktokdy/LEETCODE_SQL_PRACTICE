# Write your MySQL query statement below
with base as (
    select
        user_id,
        steps_count,
        steps_date,
        sess,
        dense_rank() over (partition by user_id,sess order by steps_date) as rnums
    from (
    select 
        user_id,
        steps_count,
        steps_date,
        date_sub(steps_date,interval dense_rank() over (partition by user_id order by steps_date) day) as sess
    from 
        Steps
    ) a
)
select 
    user_id,
    steps_date,
    rolling_average
from (
    select 
        user_id,
        steps_date,
        rnums,
        round(avg(steps_count) over (partition by user_id,sess order by steps_date range between 
            interval 2 day preceding and current row),2) as rolling_average
    from 
        base 
) a
where 
    rnums >= 3
order by 
    user_id, steps_date