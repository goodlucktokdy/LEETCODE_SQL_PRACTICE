with base as (
    select 
        activity,
        count(id) over (partition by activity) as cnts
    from 
        Friends
)
, ranking as (
    select 
        activity,
        dense_rank() over (order by cnts desc) as ranks
    from 
        base
)
select 
    distinct 
    activity
from 
    ranking 
where
    ranks < (select max(ranks) from ranking) 
    and
    ranks > (select min(ranks) from ranking)   