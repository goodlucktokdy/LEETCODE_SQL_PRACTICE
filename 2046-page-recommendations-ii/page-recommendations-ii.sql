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
),
pages_info as (
    select 
        b.user1_id,
        a.page_id as user1_page,
        b.user2_id,
        c.page_id as user2_page
    from 
        Likes a 
    inner join 
        pairs b 
    on 
        a.user_id = b.user1_id 
    inner join 
        Likes c 
    on 
        b.user2_id = c.user_id
)
select 
    a.user1_id as user_id,
    a.user2_page as page_id,
    count(distinct a.user2_id) as friends_likes
from 
    pages_info a 
left join 
    Likes b 
on 
    a.user1_id = b.user_id and a.user2_page = b.page_id
where 
    b.page_id is null
group by 
    user_id, page_id 