# Write your MySQL query statement below
select 
    distinct
    age_bucket,
    round(100.0*send_sum/(open_sum + send_sum),2) as send_perc,
    round(100.0*open_sum/(open_sum + send_sum),2) as open_perc
from (
    select 
        b.age_bucket,
        sum(case when activity_type = 'open' then time_spent else 0 end) as open_sum,
        sum(case when activity_type = 'send' then time_spent else 0 end) as send_sum
    from 
        Activities a 
    inner join 
        Age b 
    on 
        a.user_id = b.user_id 
    group by 
        b.age_bucket
) a