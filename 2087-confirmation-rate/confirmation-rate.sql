# Write your MySQL query statement below
with base as (
    select 
        a.user_id,
        b.time_stamp,
        b.action
    from
        Signups a
    left join
        Confirmations b
    on 
        a.user_id = b.user_id
)
select 
    user_id,
    coalesce(round(count(distinct case when action = 'confirmed' then time_stamp end)/count(distinct time_stamp),2),0) as confirmation_rate
from 
    base 
group by 
    user_id