# Write your MySQL query statement below
select 
    count(distinct a.account_id) as accounts_count
from 
    Subscriptions a 
left join 
    Streams b 
on 
    a.account_id = b.account_id and year(b.stream_date) = 2021
where
    2021 between year(a.start_date) and year(a.end_date)
    and b.account_id is null
