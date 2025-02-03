# Write your MySQL query statement below
with call_pairs as (
    select 
        caller_id,
        recipient_id,
        call_time
    from 
        Calls 
    union all
    select 
        recipient_id,
        caller_id,
        call_time
    from 
        Calls
),
sequence_info as (
    select 
        caller_id,
        recipient_id,
        date(call_time) as call_dates,
        call_time,
        row_number() over (partition by date(call_time),caller_id order by call_time asc) as first_call,
        row_number() over (partition by date(call_time),caller_id order by call_time desc) as last_call
    from 
        call_pairs
)
select 
    distinct
    caller_id as user_id
from 
    sequence_info
where 
    first_call = 1 or last_call = 1
group by 
    call_dates, user_id
having 
    count(distinct recipient_id) = 1