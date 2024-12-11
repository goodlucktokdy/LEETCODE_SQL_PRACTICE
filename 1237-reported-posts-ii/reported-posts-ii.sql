# Write your MySQL query statement below
with base as (
    select 
        a.post_id,
        a.action_date,
        a.action,
        a.extra,
        b.remove_date
    from 
        Actions a 
    left join 
        Removals b 
    on 
        a.post_id = b.post_id
    where 
        a.action = 'report' and a.extra = 'spam'
)
select 
    round(avg(a.removals),2) as average_daily_percent
from (
    select
        action_date,
        coalesce(100.0*count(distinct case when remove_date is not null then post_id else null end)/count(distinct post_id),0) as removals
    from 
        base
    group by 
        1
) a 
