select 
    date(request_at) as Day,
    round(count(distinct case when status like '%cancel%' then id end)/count(distinct id),2) as 'Cancellation Rate'
from 
    Trips t 
where not exists 
    (select 1 from Users u 
        where u.banned = 'Yes' and (t.client_id = u.users_id or t.driver_id = u.users_id))
and 
    date(request_at) between '2013-10-01' and '2013-10-03'
group by 
    Day 