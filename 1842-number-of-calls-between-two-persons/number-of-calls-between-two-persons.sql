# Write your MySQL query statement below
with pairs as (
    select 
        from_id,
        to_id,
        duration
    from 
        Calls
    union all
    select 
        to_id,
        from_id,
        duration
    from 
        Calls
)
select 
    from_id as person1,
    to_id as person2,
    count(to_id) as call_count,
    sum(duration) as total_duration
from 
    pairs 
group by 
    person1, person2
having 
    person1 < person2