# Write your MySQL query statement below
with accounts_cte as (
    select 
        distinct
        account_id
    from 
        Subscriptions
    where 
        2021 between year(start_date) and year(end_date)
)
select 
    count(distinct a.account_id) as accounts_count
from 
    accounts_cte a 
left join 
    Streams b 
on 
    a.account_id = b.account_id and year(b.stream_date) = 2021
where 
    b.account_id is null 