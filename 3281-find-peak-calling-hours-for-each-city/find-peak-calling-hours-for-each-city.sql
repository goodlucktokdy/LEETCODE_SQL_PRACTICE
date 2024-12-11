# Write your MySQL query statement below
with base as (
    select 
        a.city,
        a.calling_hour,
        a.number_of_calls,
        dense_rank() over (partition by a.city order by a.number_of_calls desc) as ranks
    from (
        select 
            distinct
            city,
            hour(call_time) as calling_hour,
            count(call_time) over (partition by city, date_format(call_time,'%H')) as number_of_calls
        from 
            Calls
    ) a 
)
select 
    distinct
    city,
    calling_hour as peak_calling_hour,
    number_of_calls
from 
    base 
where 
    ranks = 1
order by 
    peak_calling_hour desc,city desc