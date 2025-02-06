# Write your MySQL query statement below
select 
    business_id
from (
    select 
        business_id,
        event_type,
        occurrences,
        avg(occurrences) over (partition by event_type) as avg_occurrences
    from 
        Events
) a 
where 
    occurrences > avg_occurrences
group by 
    business_id
having 
    count(distinct event_type) > 1