# Write your MySQL query statement below
with base as (
    select 
        question_id,
        dense_rank() over (order by answer_rate desc, question_id asc) as ranks
    from (
        select 
            question_id,
            count(case when action = 'answer' then question_id else null end)/count(case when action = 'show' then question_id else null end) as answer_rate
        from 
            SurveyLog
        group by 
            id,question_id
    ) a
)
select 
    distinct
    question_id as survey_log
from 
    base 
where 
    ranks = 1