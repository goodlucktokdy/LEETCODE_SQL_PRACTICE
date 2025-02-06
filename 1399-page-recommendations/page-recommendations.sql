# Write your MySQL query statement below
with pairs as (
    select 
        user1_id,
        user2_id
    from 
        Friendship
    where 
        user1_id = 1
    union all
    select 
        user2_id,
        user1_id
    from 
        Friendship
    where 
        user2_id = 1
)
select 
    distinct 
    b.page_id as recommended_page
from 
    pairs a 
inner join 
    Likes b 
on 
    a.user2_id = b.user_id
where 
    b.page_id not in (select page_id from Likes where user_id = 1)