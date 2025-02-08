# Write your MySQL query statement below
select 
    age_bucket,
    round(100.0*send_time/total_time,2) as send_perc,
    round(100.0*open_time/total_time,2) as open_perc
from (
    select 
        a.age_bucket,
        sum(case when b.activity_type = 'send' then b.time_spent else 0 end) as send_time,
        sum(case when b.activity_type = 'open' then b.time_spent else 0 end) as open_time,
        sum(b.time_spent) as total_time
    from 
        Age a 
    inner join 
        Activities b 
    on 
        a.user_id = b.user_id
    group by 
        a.age_bucket
) a
