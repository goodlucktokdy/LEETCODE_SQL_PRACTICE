# Write your MySQL query statement below
select 
    a.user_id,
    round(coalesce(count(distinct case when b.action = 'confirmed' then b.time_stamp else null end)/count(distinct b.time_stamp),0),2) as confirmation_rate
from 
    Signups a 
left join 
    Confirmations b 
on 
    a.user_id = b.user_id 
group by 
    a.user_id