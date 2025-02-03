# Write your MySQL query statement below
with exam_info as (
    select 
        b.exam_id,
        a.student_id,
        a.student_name,
        b.score,
        dense_rank() over (partition by b.exam_id order by b.score desc) as high_score,
        dense_rank() over (partition by b.exam_id order by b.score asc) as low_score
    from 
        Student a 
    inner join 
        Exam b 
    on 
        a.student_id = b.student_id
)
select 
    distinct
    student_id,
    student_name
from 
    exam_info a 
where not exists 
    (select 1 from exam_info b 
        where a.student_id = b.student_id and (b.high_score = 1 or b.low_score = 1))
order by 
    student_id asc 