# Write your MySQL query statement below
with base as (
    select 
        person_name,
        cume_weight,
        turn
    from (
        select 
            person_name,
            turn,
            sum(weight) over (order by turn) as cume_weight,
            1000 as limits
        from 
            Queue
    ) a 
    where 
        cume_weight <= limits
)
select 
    person_name
from (
    select 
        person_name,
        dense_rank() over (order by turn desc) as ranks
    from 
        base 
) a
where 
    ranks = 1