select
    a.student_id,
    min(a.course_id) as course_id,
    a.grade
from (
    select
        student_id,
        course_id,
        grade,
        rank() over (partition by student_id order by grade desc) as ranks
    from 
        Enrollments
) a
where 
    ranks = 1
group by
    a.student_id, a.grade
order by 
    a.student_id asc