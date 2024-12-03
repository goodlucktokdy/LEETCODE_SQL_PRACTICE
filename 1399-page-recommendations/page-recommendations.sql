with base as (
    select
        user1_id as user
    from 
        Friendship
    where 
        user1_id = 1 or user2_id = 1
    union all
    select
        user2_id as user
    from 
        Friendship
    where 
        user1_id = 1 or user2_id = 1
)
select
    distinct
    b.page_id as recommended_page
from 
    base a
inner join
    Likes b
on 
    a.user = b.user_id
where
    a.user != 1 and b.page_id not in (select distinct page_id from Likes where user_id = 1)