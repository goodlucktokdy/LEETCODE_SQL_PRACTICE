# Write your MySQL query statement below
with base as (
    select 
        a.candidate,
        sum(a.rate) as votes
    from (
        select
            voter,
            candidate,
            coalesce(1/count(candidate) over (partition by voter),0) as rate
        from 
            Votes
    ) a
    group by 
        1
)
select 
    candidate
from 
    base 
where 
    votes = (select max(votes) from base)
order by 
    candidate asc
