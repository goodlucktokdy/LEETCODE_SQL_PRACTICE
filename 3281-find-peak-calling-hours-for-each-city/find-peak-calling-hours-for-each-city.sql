# Write your MySQL query statement below
with base as (
    select 
        city,
        hour,
        number_of_calls,
        dense_rank() over (partition by city order by number_of_calls desc) as ranks
    from (
        select 
            city,
            extract(hour from call_time) as hour,
            count(distinct call_time) as number_of_calls
        from 
            Calls
        group by 
            city, hour
    ) a
)
select 
    city,
    hour as peak_calling_hour,
    number_of_calls
from 
    base 
where 
    ranks = 1
order by 
    peak_calling_hour desc, city desc 