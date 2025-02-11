# Write your MySQL query statement below
select 
    count(case when weekday(submit_date) in (5,6) then task_id else null end) as weekend_cnt,
    count(case when weekday(submit_date) in (0,1,2,3,4) then task_id else null end) as working_cnt
from 
    Tasks