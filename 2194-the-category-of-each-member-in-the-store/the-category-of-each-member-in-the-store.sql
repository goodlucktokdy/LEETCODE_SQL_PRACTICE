# Write your MySQL query statement below
with visit_cte as (
    select 
        a.member_id,
        a.name,
        b.visit_id
    from 
        Members a 
    left join 
        Visits b 
    on 
        a.member_id = b.member_id    
)
select 
    member_id,
    name,
    case when visits = 0 then 'Bronze'
        when conversion_rate >= 80 then 'Diamond'
        when conversion_rate >= 50 then 'Gold'
        else 'Silver' end as category
from (
    select 
        a.member_id,
        a.name,
        count(distinct a.visit_id) as visits,
        100.0*count(distinct b.visit_id)/count(distinct a.visit_id) as conversion_rate
    from 
        visit_cte a 
    left join 
        Purchases b
    on 
        a.visit_id = b.visit_id
    group by 
        a.member_id, a.name
) a