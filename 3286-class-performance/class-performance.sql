# Write your MySQL query statement below
select 
    max(total_score) - min(total_score) as difference_in_score
from (
    select 
        student_id,
        sum(assignment1 + assignment2 + assignment3) as total_score
    from 
        Scores
    group by 
        student_id
) a