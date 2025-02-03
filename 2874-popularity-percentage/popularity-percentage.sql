with pairs as (
    select 
        user1,
        user2
    from 
        Friends
    union all
    select 
        user2,
        user1
    from 
        Friends
)
select 
    user1,
    round(100.0*count(distinct user2)/(select count(distinct user1) from pairs),2) as percentage_popularity
from 
    pairs
group by 
    user1
order by 
    user1