with base as (
    select 
        a.exam_id,
        a.student_id,
        b.student_name,
        a.score,
        dense_rank() over (partition by a.exam_id order by a.score desc) as high_score,
        dense_rank() over (partition by a.exam_id order by a.score asc) as low_score
    from 
        Exam a 
    inner join 
        Student b 
    on 
        a.student_id = b.student_id
)
select 
    distinct 
    student_id,
    student_name
from 
    base a
where not exists
    (select 1 from base b 
        where a.student_id = b.student_id and (b.high_score = 1 or b.low_score = 1))
order by 
    student_id 