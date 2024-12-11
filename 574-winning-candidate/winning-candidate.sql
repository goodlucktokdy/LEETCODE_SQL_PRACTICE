with base as (
    select 
        count(a.id) over (partition by a.candidateId) as votes,
        b.name
    from 
        Vote a 
    inner join 
        Candidate b 
    on
        a.candidateId = b.id 
)
select 
    distinct
    a.name
from (
    select 
        name,
        votes,
        max(votes) over () as max_votes
    from 
        base
    group by
        name
) a
where 
    a.votes = a.max_votes