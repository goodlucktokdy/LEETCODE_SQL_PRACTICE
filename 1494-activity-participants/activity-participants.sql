# Write your MySQL query statement below
with base as (
    select 
        activity,
        cnts,
        dense_rank() over (order by cnts desc) as first_ranks,
        dense_rank() over (order by cnts asc) as low_ranks
    from (
        select 
            distinct
            activity,
            count(id) over (partition by activity) as cnts
        from 
            Friends
    ) a
)
select 
    distinct
    activity 
from 
    base a 
where not exists 
    (select 1 from base b 
        where a.activity = b.activity and (b.first_ranks = 1 or b.low_ranks = 1))