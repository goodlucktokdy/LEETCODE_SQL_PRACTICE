# Write your MySQL query statement below
with base as (
    select 
        city,
        hours,
        cnts,
        dense_rank() over (partition by city order by cnts desc) as ranks
    from (
        select 
            city,
            extract(hour from call_time) as hours,
            count(extract(hour from call_time)) as cnts
        from 
            Calls
        group by 
            city, extract(hour from call_time)
    ) a
)
select 
    city,
    hours as peak_calling_hour,
    cnts as number_of_calls
from 
    base 
where 
    ranks = 1
order by 
    peak_calling_hour desc, city desc