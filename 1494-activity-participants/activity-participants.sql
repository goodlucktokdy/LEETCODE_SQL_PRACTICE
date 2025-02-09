# Write your MySQL query statement below
with base as (
    select 
        activity,
        cnts,
        max(cnts) over () as max_num,
        min(cnts) over () as min_num
    from (
        select
            a.name as activity,
            count(distinct b.id) as cnts
        from 
            Activities a 
        left join 
            Friends b 
        on 
            a.name = b.activity
        group by 
            a.name
    ) a
)
select 
    distinct
    activity
from 
    base a 
where not exists 
    (select 1 from base b 
        where a.activity = b.activity and (b.max_num = b.cnts or b.min_num = b.cnts))