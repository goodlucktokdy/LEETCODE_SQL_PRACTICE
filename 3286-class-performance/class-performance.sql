# Write your MySQL query statement below
select 
    max_score - min_score as difference_in_score
from (
    select 
        max(assignment1 + assignment2 + assignment3) as max_score,
        min(assignment1 + assignment2 + assignment3) as min_score
    from 
        Scores
) a
