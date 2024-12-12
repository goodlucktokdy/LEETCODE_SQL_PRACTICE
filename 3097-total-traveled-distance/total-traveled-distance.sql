# Write your MySQL query statement below
select 
    a.user_id,
    a.name,
    coalesce(sum(b.distance),0) as 'traveled distance'
from 
    Users a 
left join 
    Rides b 
on 
    a.user_id = b.user_id
group by 
    1,2
order by 
    a.user_id 