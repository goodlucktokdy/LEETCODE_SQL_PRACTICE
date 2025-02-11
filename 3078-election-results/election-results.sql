# Write your MySQL query statement below
with base as (
    select
        candidate,
        sum(cnts) as sums
    from (
        select 
            candidate,
            1/count(case when candidate is not null then voter else null end) over (partition by voter) as cnts
        from 
            Votes
    ) a
    group by 
        candidate
)
select 
    distinct 
    candidate
from (
    select 
        candidate,
        dense_rank() over (order by sums desc) as ranks
    from 
        base
) a
where 
    candidate is not null and ranks = 1
order by
    candidate