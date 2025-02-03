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
base as (
    select 
        a.day,
        a.song_id,
        a.user_id as user1_id,
        b.user_id as user2_id
    from 
        Listens a 
    inner join 
        Listens b 
    on 
        a.day = b.day and a.song_id = b.song_id and a.user_id != b.user_id
)
select 
    distinct 
    user1_id,
    user2_id 
from 
    base a 
where exists 
    (select 1 from pairs b 
        where a.user1_id = b.user1_id and a.user2_id = b.user2_id)
group by 
    day,user1_id,user2_id
having 
    count(distinct song_id) >= 3 and user1_id < user2_id