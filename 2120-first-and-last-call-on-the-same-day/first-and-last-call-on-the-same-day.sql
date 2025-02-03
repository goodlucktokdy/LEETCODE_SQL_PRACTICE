with base as (
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
)
select 
    distinct
    caller_id as user_id
from (
    select 
        caller_id,
        recipient_id,
        date(call_time) as dates,
        call_time,
        row_number() over (partition by date(call_time),caller_id order by call_time) as first_call,
        row_number() over (partition by date(call_time),caller_id order by call_time desc) as last_call
    from 
        base 
) a 
where 
    first_call = 1 or last_call = 1
group by 
    user_id,dates
having 
    count(distinct recipient_id) = 1