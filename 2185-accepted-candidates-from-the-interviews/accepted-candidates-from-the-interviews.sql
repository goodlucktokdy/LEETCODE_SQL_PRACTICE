# Write your MySQL query statement below
select 
    distinct 
    candidate_id
from (
    select 
        a.candidate_id,
        a.interview_id,
        sum(b.score) as score
    from 
        Candidates a 
    inner join 
        Rounds b 
    on 
        a.interview_id = b.interview_id and a.years_of_exp >= 2
    group by 
        a.candidate_id,a.interview_id
) a
where 
    score > 15