# Write your MySQL query statement below
select 
    a.follower,
    count(distinct b.follower) as num
from 
    Follow a 
left join 
    Follow b 
on 
    a.follower = b.followee
where 
    b.followee is not null
group by 
    a.follower
order by 
    a.follower