# Write your MySQL query statement below
with base as (
    select 
        user_id,
        steps_date,
        steps_count,
        sess,
        cast(row_number() over (partition by user_id, sess order by steps_date) as real) as rnums,
        count(steps_date) over (partition by sess) as cnts
    from (
        select 
            user_id,
            steps_date,
            date_sub(steps_date, interval row_number() over (partition by user_id order by steps_date) day) as sess,
            steps_count
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
        round(avg(steps_count) over (partition by user_id, sess order by rnums range between 2 preceding and current row),2) as rolling_average 
    from 
        base 
    where 
        cnts >= 3
) a
where 
    rnums >= 3
order by 
    user_id, steps_date