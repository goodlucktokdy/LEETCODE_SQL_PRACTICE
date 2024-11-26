# Write your MySQL query statement below
select 
    a.person_name
from (
    select 
        person_id,
        person_name,
        sum(weight) over (order by turn asc) as cumsum,
        turn
    from 
        Queue
) a
where
    cumsum <= 1000
order by 
    turn desc
limit 1