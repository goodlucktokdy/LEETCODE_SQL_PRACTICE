# Write your MySQL query statement below
with base as (
    select 
        fail_date as dates,
        'failed' as period_state
    from 
        Failed
    union all
    select 
        success_date as dates,
        'succeeded' as period_state
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
        dates between '2019-01-01' and '2019-12-31'
) a 
group by 
    period_state,sess
order by 
    start_date