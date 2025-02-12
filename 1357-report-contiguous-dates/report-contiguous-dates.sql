# Write your MySQL query statement below
with base as (
    select 
        'failed' as period_state,
        fail_date as dates
    from 
        Failed
    union all
    select 
        'succeeded' as period_state,
        success_date as dates
    from 
        Succeeded
)
select 
    period_state,
    min(dates) as start_date,
    max(dates) as end_date
from (
    select 
        period_state,
        dates,
        date_sub(dates,interval row_number() over (partition by period_state order by dates) day) as sess
    from 
        base
    where 
        year(dates) = 2019
) a
group by 
    period_state,sess
order by 
    start_date