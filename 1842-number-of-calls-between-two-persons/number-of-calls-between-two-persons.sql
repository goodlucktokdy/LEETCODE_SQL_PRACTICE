# Write your MySQL query statement below
with pairs as (
    select 
        row_number() over () as rnums,
        from_id as person1,
        to_id as person2,
        duration
    from 
        Calls
    union all
    select 
        row_number() over () as rnums,
        to_id,
        from_id,
        duration
    from 
        Calls
)
select 
    a.person1,
    a.person2,
    count(b.person2) as call_count,
    sum(b.duration) as total_duration
from 
    pairs a
inner join 
    pairs b 
on 
    a.rnums = b.rnums and a.person1 = b.person1 and a.person2 = b.person2
group by 
    a.person1, a.person2
having 
    a.person1 < a.person2