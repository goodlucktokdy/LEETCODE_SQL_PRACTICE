# Write your MySQL query statement below
select 
    student_id,
    course_id,
    grade
from (
    select 
        student_id,
        course_id,
        grade,
        dense_rank() over (partition by student_id order by grade desc, course_id asc) as ranks
    from 
        Enrollments
) a
where 
    ranks = 1
order by 
    student_id 