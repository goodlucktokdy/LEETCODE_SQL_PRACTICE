# Write your MySQL query statement below
with base as (
    select 
        a.candidate_id,
        a.years_of_exp,
        b.interview_id,
        b.round_id,
        b.score
    from 
        Candidates a 
    left join 
        Rounds b 
    on 
        a.interview_id = b.interview_id
)
,final_info as (
    select 
        candidate_id,
        interview_id,
        sum(score) as total_score
    from 
        base
    where 
        years_of_exp >= 2
    group by 
        1,2
    having 
        sum(score) > 15
)
select 
    distinct 
    candidate_id
from 
    final_info