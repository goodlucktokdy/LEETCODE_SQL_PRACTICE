# Write your MySQL query statement below
with base as (
    select 
        a.account_id,
        b.start_date,
        a.stream_date
    from 
        Streams a 
    left join 
        Subscriptions b 
    on 
        a.account_id = b.account_id
    where 
        (year(b.end_date) = 2021 or year(b.start_date) = 2021) and year(a.stream_date) != 2021
)
select 
    count(distinct account_id) as accounts_count
from 
    base