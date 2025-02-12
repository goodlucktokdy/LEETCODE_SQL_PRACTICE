# Write your MySQL query statement below
with base as (
    select 
        id,
        dense_rank() over (order by votes desc) as ranks
    from (
        select 
            a.id,
            count(distinct b.id) as votes
        from 
            Candidate a 
        left join 
            Vote b 
        on 
            a.id = b.candidateId
        group by 
            a.id
    ) c
)
select 
    a.name
from 
    Candidate a 
inner join 
    base b
on 
    a.id = b.id
where 
    b.ranks = 1