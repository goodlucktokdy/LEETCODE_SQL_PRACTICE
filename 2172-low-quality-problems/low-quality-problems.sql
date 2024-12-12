# Write your MySQL query statement below
select 
    distinct 
    a.problem_id
from (
    select 
        problem_id,
        ifnull(likes/(likes+ dislikes),0) as rate
    from 
        Problems
) a 
where 
    a.rate < 0.60
order by 
    a.problem_id asc