# Write your MySQL query statement below
select 
    person_name
from (
    select 
        person_name,
        sum(weight) over (order by turn) as cume_weight,
        turn
    from 
        Queue
) a
where 
    cume_weight <= 1000
order by 
    turn desc 
limit 1