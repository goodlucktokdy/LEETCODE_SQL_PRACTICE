# Write your MySQL query statement below
select 
    round(100.0*avg(daily_percent),2) as average_daily_percent
from (
    select 
        a.action_date,
        count(distinct case when a.action = 'report' and a.extra = 'spam' then b.post_id else null end)/count(distinct case when a.action = 'report' and a.extra = 'spam' then a.post_id else null end) as daily_percent
    from 
        Actions a 
    left join 
        Removals b 
    on 
        a.post_id = b.post_id
    group by 
        a.action_date
) a
