# Write your MySQL query statement below
with pairs as (
    select 
        user1_id,
        user2_id
    from 
        Friendship
    union all
    select 
        user2_id,
        user1_id
    from 
        Friendship
)
select 
    a.user1_id as user1_id,
    b.user1_id as user2_id,
    count(distinct b.user2_id) as common_friend
from 
    pairs a
inner join 
    pairs b 
on 
    a.user2_id = b.user2_id 
inner join 
    pairs c 
on 
    a.user1_id = c.user1_id and b.user1_id = c.user2_id
where 
    a.user1_id < b.user1_id
group by 
    a.user1_id, b.user1_id
having 
    common_friend >= 3