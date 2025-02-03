select 
    date(request_at) as Day,
    round(coalesce(count(distinct case when status like '%cancelled%' then id else null end)/count(distinct id),0),2) as 'Cancellation Rate'
from
    Trips t
where not exists 
    (select 1 from Users u 
        where u.banned = 'Yes' and (u.users_id = t.client_id or u.users_id = t.driver_id))
    and 
        date(request_at) between '2013-10-01' and '2013-10-03'
group by 
    Day