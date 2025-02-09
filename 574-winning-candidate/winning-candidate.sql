# Write your MySQL query statement below
with base as (
    select 
        candidate_id,
        name,
        count(distinct vote_id) as cnts
    from (
        select 
            a.id as candidate_id,
            a.name,
            b.id as vote_id
        from 
            Candidate a 
        inner join 
            Vote b 
        on
            a.id = b.candidateId
    ) a 
    group by 
        candidate_id
)
select 
    name
from (
    select 
        candidate_id,
        name,
        dense_rank() over (order by cnts desc) as ranks
    from 
        base 
) a
where 
    ranks = 1