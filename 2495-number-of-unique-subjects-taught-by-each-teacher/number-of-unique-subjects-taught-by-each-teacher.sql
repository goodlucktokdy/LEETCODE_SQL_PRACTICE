# Write your MySQL query statement below
select 
    a.teacher_id,
    count(distinct a.subject_id) as cnt
from (
    select 
        teacher_id,
        subject_id
    from 
        Teacher
) a
group by 
    a.teacher_id