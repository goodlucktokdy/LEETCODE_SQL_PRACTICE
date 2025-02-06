# Write your MySQL query statement below
with base as (
    select 
        a.post_id,
        a.extra,
        a.action_date,
        b.remove_date
    from 
        Actions a 
    left join 
        Removals b 
    on 
        a.post_id = b.post_id
    where
        a.extra = 'spam'
)
select 
    round(100.0 * avg(removed),2) as average_daily_percent
from (
    select 
        action_date,
        count(distinct case when remove_date is not null then post_id else null end)/count(distinct post_id) as removed
    from 
        base 
    group by 
        action_date
) a 