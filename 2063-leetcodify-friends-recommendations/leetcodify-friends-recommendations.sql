# Write your MySQL query statement below
with base as (
    select 
        a.day,
        a.song_id,
        a.user_id as user1,
        b.user_id as user2
    from 
        Listens a 
    inner join 
        Listens b 
    on 
        a.day = b.day and a.song_id = b.song_id and a.user_id != b.user_id
),
pairs as (
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
    distinct 
    user1 as user_id,
    user2 as recommended_id
from 
    base a
where not exists 
    (select 1 from pairs b
        where a.user1 = b.user1_id and a.user2 = b.user2_id)
group by 
    day, user1,user2
having 
    count(distinct song_id) >= 3