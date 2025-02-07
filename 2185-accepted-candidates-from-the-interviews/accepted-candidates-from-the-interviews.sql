# Write your MySQL query statement below
select 
    candidate_id
from (
    select 
        a.candidate_id,
        a.years_of_exp,
        a.interview_id,
        sum(b.score) as score
    from 
        Candidates a 
    inner join 
        Rounds b 
    on 
        a.interview_id = b.interview_id
    where 
        a.years_of_exp >= 2
    group by 
        a.candidate_id, a.interview_id, a.years_of_exp
    having 
        score > 15
) a