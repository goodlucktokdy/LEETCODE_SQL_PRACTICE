# Write your MySQL query statement below
select 
    distinct
    max(a.total_score) over () - min(a.total_score) over () as difference_in_score
from (
    select 
        student_id,
        student_name,
        assignment1 + assignment2 + assignment3 as total_score
    from 
        Scores
) a