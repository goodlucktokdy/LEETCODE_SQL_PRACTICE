# Write your MySQL query statement below
select 
    ad_id,
    coalesce(round(100.0*count(case when action = 'Clicked' then user_id end)/count(case when action != 'ignored' then user_id end),2),0) as ctr
from 
    Ads
group by 
    ad_id
order by 
    ctr desc, ad_id asc