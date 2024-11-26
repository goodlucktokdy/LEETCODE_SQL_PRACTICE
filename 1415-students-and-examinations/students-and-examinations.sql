# Write your MySQL query statement below
with base as (
    select 
        a.student_id,
        a.student_name,
        b.subject_name
    from 
        Students a
    cross join
        Subjects b
)
, exam_cnts as (
    select 
        student_id,
        subject_name,
        count(subject_name) as sub_cnt
    from 
        Examinations
    group by 
        1,2
)
select 
    a.student_id,
    a.student_name,
    a.subject_name,
    case when a.attended_exams is null then 0 else a.attended_exams end as attended_exams
from (
    select 
        a.student_id,
        a.student_name,
        a.subject_name,
        b.sub_cnt as attended_exams
    from 
        base a 
    left join 
        exam_cnts b
    on 
        a.student_id = b.student_id and a.subject_name = b.subject_name
) a
order by 
    a.student_id, a.subject_name