# Write your MySQL query statement below
select 
    person_name
from (
    select 
        person_id,
        person_name,
        turn,
        sum(weight) over (order by turn) as cume_weight,
        1000 as limits
    from 
        Queue
) a
where 
    cume_weight <= limits
order by 
    turn desc
limit 1