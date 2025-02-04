# Write your MySQL query statement below
select 
    t.request_at as Day,
    round(coalesce(count(distinct case when t.status like '%cancel%' then t.id else null end)/count(distinct t.id),0),2) as 'Cancellation Rate'
from 
    Trips t 
left join 
    Users u
on 
    u.banned = 'Yes' and (t.client_id = u.users_id or t.driver_id = u.users_id)
where 
    u.users_id is null and t.request_at between '2013-10-01' and '2013-10-03'
group by 
    Day