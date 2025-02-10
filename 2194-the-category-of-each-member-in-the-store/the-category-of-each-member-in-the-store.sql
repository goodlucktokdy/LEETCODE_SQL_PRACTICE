# Write your MySQL query statement below
with base as (
    select 
        a.member_id,
        100.0*count(distinct b.visit_id)/count(distinct a.visit_id) as conversion_rate
    from 
        Visits a 
    left join
        Purchases b 
    on 
        a.visit_id = b.visit_id
    group by 
        a.member_id
)
select 
    a.member_id,
    a.name,
    case when b.conversion_rate is null then 'Bronze'
        when b.conversion_rate >= 80 then 'Diamond'
        when b.conversion_rate >= 50 then 'Gold'
        else 'Silver' end as category
from 
    Members a 
left join 
    base b 
on 
    a.member_id = b.member_id