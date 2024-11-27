# Write your MySQL query statement below
select 
    case when max_id + 1 = new_id and max_id % 2 = 1 then 
    a.new_id - 1 else a.new_id end as id,
    a.student
from (
    select 
        id,
        student,
        case when id % 2 = 1 then id + 1 
        else id - 1 end as new_id,
        max(id) over () as max_id
    from 
        Seat
) a
order by 
    id
