# Write your MySQL query statement below
select 
    extra as report_reason,
    count(distinct post_id) as report_count
from 
    Actions 
where 
    timestampdiff(day,action_date, '2019-07-05') = 1 and action = 'report'
group by 
    extra
