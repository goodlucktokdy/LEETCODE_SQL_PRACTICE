# Write your MySQL query statement below
select 
    distinct
    gender,
    day,
    sum(score_points) over (partition by gender order by day asc) as total
from 
    Scores
order by 
    gender, day