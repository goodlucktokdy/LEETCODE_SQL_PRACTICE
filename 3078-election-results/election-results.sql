# Write your MySQL query statement below
with base as (
    select 
        candidate,
        sum(1/voter_cnts) as votes
    from (
        select 
            voter,
            count(voter) over (partition by voter) as voter_cnts,
            candidate
        from 
            Votes
    ) a
    group by 
        candidate
)
select 
    candidate
from (
    select 
        candidate,
        dense_rank() over (order by votes desc) as ranks
    from 
        base
) a
where 
    ranks = 1
order by
    candidate asc 