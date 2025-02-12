# Write your MySQL query statement below
with base as (
    select 
        person_id,
        rnums,
        max(rnums) over () as max_rnums
    from (
        select 
            person_id,
            person_name,
            turn,
            row_number() over (order by turn) as rnums,
            sum(weight) over (order by turn) as cume_weight
        from 
            Queue
    ) a
    where 
        cume_weight <= 1000
)
select 
    a.person_name
from 
    Queue a 
inner join 
    base b 
on 
    a.person_id = b.person_id and b.max_rnums = b.rnums