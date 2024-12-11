# Write your MySQL query statement below
with base as (
    select 
        a.business_id
    from (
        select 
            distinct
            business_id,
            event_type,
            occurrences,
            avg(occurrences) over (partition by event_type) as avg_occurrences_in_event
        from 
            Events
    ) a 
    where 
        occurrences > avg_occurrences_in_event 
)
select 
    distinct 
    business_id
from 
    base
group by 
    business_id
having 
    count(*) > 1