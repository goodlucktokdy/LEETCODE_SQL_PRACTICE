# Write your MySQL query statement below
select 
    distinct 
    a.candidate_id
from (
    select
        candidate_id,
        sum(case when skill in ('Tableau','PostgreSQL','Python') then 1 else 0 end) over (partition by candidate_id) as sessions
    from 
        Candidates
) a
where 
    sessions = 3