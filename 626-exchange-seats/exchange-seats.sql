# Write your MySQL query statement below
select
    case when 
        (select max(id) from Seat) = id and id % 2 then id 
        when id % 2 then id + 1
        else id - 1 end as id,
    student
from 
    Seat
order by 
    id 