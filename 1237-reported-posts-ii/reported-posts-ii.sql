# Write your MySQL query statement below
select 
    round(avg(100.0*avg_percent),2) as average_daily_percent
from (
    select 
        a.action_date,
        count(distinct case when a.extra = 'spam' then b.post_id else null end)/count(distinct a.post_id) as avg_percent
    from 
        Actions a 
    left join 
        Removals b 
    on 
        a.post_id = b.post_id 
    where 
        a.extra = 'spam' 
    group by 
        a.action_date
) a